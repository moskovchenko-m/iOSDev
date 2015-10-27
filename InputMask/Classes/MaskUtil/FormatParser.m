//
//  FormatParser.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "FormatParser.h"

#import "MultiCharacterValueableComponent.h"
#import "ValueableCharacterComponent.h"
#import "FreeCharacterComponent.h"
#import "EOLComponent.h"

#import "NSString+Character.h"
#include "Constants.h"

@implementation FormatParser

#pragma mark - Публичные методы

- (NSArray *)componentsFromFormatString:(NSString *)format
{
    BOOL valuableBlock = NO;
    BOOL includedConstantBlock = NO;

    return [self componentsFromFormatString:format
                              valuableBlock:valuableBlock
                      includedConstantBlock:includedConstantBlock];
}

#pragma mark - Частные методы


- (NSArray *)componentsFromFormatString:(NSString *)format
                          valuableBlock:(BOOL)valuableBlock
                  includedConstantBlock:(BOOL)staticBlock
{
    BOOL lastFormatCharacter = [format length] <= 1;

    if (lastFormatCharacter) {
        return @[[[EOLComponent alloc] init]];
    }

    unichar formatCharacter = [format characterAtIndex:0];
    NSString *subFormat = [format substringFromIndex:1];

    BOOL nextComponentsValuable = valuableBlock;
    if (formatCharacter == InputBlockBegin) nextComponentsValuable = YES;
    if (formatCharacter == InputBlockEnd) nextComponentsValuable = NO;

    BOOL nextComponentsIncluded = staticBlock;
    if (formatCharacter == StaticBlockBegin) nextComponentsIncluded = YES;
    if (formatCharacter == StaticBlockEnd) nextComponentsIncluded = NO;

    NSArray *nextComponents = [self componentsFromFormatString:subFormat
                                                 valuableBlock:nextComponentsValuable
                                         includedConstantBlock:nextComponentsIncluded];
    MaskComponent *nextComponent = [nextComponents firstObject];

    switch (formatCharacter) {
        case InputBlockBegin: {
            return [self componentsFromFormatString:subFormat
                                      valuableBlock:YES
                              includedConstantBlock:staticBlock];
        }

        case InputBlockEnd: {
            return [self componentsFromFormatString:subFormat
                                      valuableBlock:NO
                              includedConstantBlock:staticBlock];
        }

        case StaticBlockBegin: {
            return [self componentsFromFormatString:subFormat
                                      valuableBlock:valuableBlock
                              includedConstantBlock:YES];
        }

        case StaticBlockEnd: {
            return [self componentsFromFormatString:subFormat
                                      valuableBlock:valuableBlock
                              includedConstantBlock:NO];
        }

        // Необходимые символы:
        case RequiredNumber: {
            MaskComponent *component = [self maskComponentForRequiredCharacter:[NSString stringWithCharacter:formatCharacter]
                                                                 valuableBlock:valuableBlock
                                                                   staticBlock:staticBlock
                                                                nextComponents:nextComponents
                                                                 ownCharacters:[NSString numbers]];

            return component ? [@[component] arrayByAddingObjectsFromArray:nextComponents] : @[];
        }

        case RequiredLetter: {
            MaskComponent *component = [self maskComponentForRequiredCharacter:[NSString stringWithCharacter:formatCharacter]
                                                                 valuableBlock:valuableBlock
                                                                   staticBlock:staticBlock
                                                                nextComponents:nextComponents
                                                                 ownCharacters:[NSString letters]];

            return component ? [@[component] arrayByAddingObjectsFromArray:nextComponents] : @[];
        }

        case RequiredSymbol: {
            MaskComponent *component = [self maskComponentForRequiredCharacter:[NSString stringWithCharacter:formatCharacter]
                                                                 valuableBlock:valuableBlock
                                                                   staticBlock:staticBlock
                                                                nextComponents:nextComponents
                                                                 ownCharacters:[NSString numbersAndLetters]];

            return component ? [@[component] arrayByAddingObjectsFromArray:nextComponents] : @[];
        }

        // Опциональные символы:
        case OptionalNumber: {
            MaskComponent *component = [self maskComponentForOptionalCharacter:[NSString stringWithCharacter:formatCharacter]
                                                                 valuableBlock:valuableBlock
                                                                   staticBlock:staticBlock
                                                                nextComponents:nextComponents
                                                                 ownCharacters:[NSString numbers]];
            return component ? [@[component] arrayByAddingObjectsFromArray:nextComponents] : @[];
        }

        case OptionalLetter: {
            MaskComponent *component = [self maskComponentForOptionalCharacter:[NSString stringWithCharacter:formatCharacter]
                                                                 valuableBlock:valuableBlock
                                                                   staticBlock:staticBlock
                                                                nextComponents:nextComponents
                                                                 ownCharacters:[NSString letters]];
            return component ? [@[component] arrayByAddingObjectsFromArray:nextComponents] : @[];
        }

        case OptionalSymbol: {
            MaskComponent *component = [self maskComponentForOptionalCharacter:[NSString stringWithCharacter:formatCharacter]
                                                                 valuableBlock:valuableBlock
                                                                   staticBlock:staticBlock
                                                                nextComponents:nextComponents
                                                                 ownCharacters:[NSString numbersAndLetters]];
            return component ? [@[component] arrayByAddingObjectsFromArray:nextComponents] : @[];
        }

        default: {
            if (!valuableBlock && !staticBlock) {
                // Символ вне блоков
                NSString *character = [NSString stringWithCharacter:formatCharacter];
                MaskComponent *component = [[FreeCharacterComponent alloc] initWithCharacter:character target:nextComponent];

                return [@[component] arrayByAddingObjectsFromArray:nextComponents];
            }

            if (staticBlock) {
                // Символ в фигурных скобках
                NSString *character = [NSString stringWithCharacter:formatCharacter];
                MaskComponent *component = [[ValueableCharacterComponent alloc] initWithCharacter:character target:nextComponent];

                return [@[component] arrayByAddingObjectsFromArray:nextComponents];
            }

            // Символ в квадратных скобках: не рассматривается
            return @[];
        }
    }
}

- (MaskComponent *)maskComponentForOptionalCharacter:(NSString *)character
                                       valuableBlock:(BOOL)valuableBlock
                                         staticBlock:(BOOL)includedConstantBlock
                                      nextComponents:(NSArray *)nextComponents
                                       ownCharacters:(NSArray *)ownCharacters
{
    MaskComponent *nextComponent = [nextComponents firstObject];

    if (!valuableBlock && !includedConstantBlock) {
        // Необязательный символ вне блоков
        MaskComponent *component = [[FreeCharacterComponent alloc] initWithCharacter:character target:nextComponent];
        return component;
    }

    if (includedConstantBlock) {
        // Необязательный символ в фигурных скобках
        MaskComponent *component = [[ValueableCharacterComponent alloc] initWithCharacter:character target:nextComponent];
        return component;
    }

    // Необязательный символ в квадратных скобках
    MaskComponent *firstSubcomponentProducingPrefix = nil;

    for (MaskComponent *c in nextComponents) {
        if ([[c prefixPassingCharacter:[NSString anyCharacter]] length]) {
            firstSubcomponentProducingPrefix = c;
            break;
        }
    }

    return [[MultiCharacterValueableComponent alloc] initWithCharacters:ownCharacters
                                                         variableSymbol:YES
                                                                 target:nextComponent
                                                       collateralTarget:firstSubcomponentProducingPrefix];
}

- (MaskComponent *)maskComponentForRequiredCharacter:(NSString *)character
                                       valuableBlock:(BOOL)valuableBlock
                                         staticBlock:(BOOL)includedConstantBlock
                                      nextComponents:(NSArray *)nextComponents
                                       ownCharacters:(NSArray *)ownCharacters
{
    MaskComponent *nextComponent = [nextComponents firstObject];

    if (!valuableBlock && !includedConstantBlock) {
        // Символ вне блоков
        return [[FreeCharacterComponent alloc] initWithCharacter:character target:nextComponent];
    }

    if (includedConstantBlock) {
        // Символ в фигурных скобках
        return [[ValueableCharacterComponent alloc] initWithCharacter:character target:nextComponent];
    }

    // Символ в квадратных скобках
    return [[MultiCharacterValueableComponent alloc] initWithCharacters:ownCharacters
                                                         variableSymbol:NO
                                                                 target:nextComponent
                                                       collateralTarget:nil];
}

@end
