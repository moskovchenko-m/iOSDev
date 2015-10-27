//
//  MaskFormatter.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskFormatter.h"
#import "MaskComponent.h"
#import "NSStringIterator.h"

@implementation MaskFormatter

- (NSString *)formatText:(NSString *)text
{
    MaskComponent *component = self.firstComponent;
    NSStringIterator *stringIterator = [NSStringIterator iteratorWithString:text];
    NSString *character = [stringIterator next];

    NSMutableString *result = [[NSMutableString alloc] init];

    while (component && character) {

        if (![component canPassCharacter:character]) {
            character = [stringIterator next];
            continue;
        }

        if ([[component prefixPassingCharacter:character] length]) {
            [result appendString:[component prefixPassingCharacter:character]];
            component = [component passCharacter:character];
            continue;
        }

        BOOL variable = component.variable;
        BOOL ownSymbol = [component isOwnCharacter:character];
        component = [component passCharacter:character];

        if (!variable) {
            [result appendString:character];
            character = [stringIterator next];
        } else if (ownSymbol) {
            [result appendString:character];
            character = [stringIterator next];
        }
    }

    return result;
}

- (NSInteger)differenceInText:(NSString *)text
       afterFormattingInRange:(NSRange)range
{
    MaskComponent *component = self.firstComponent;
    NSStringIterator *stringIterator = [NSStringIterator iteratorWithString:text];
    NSString *character = [stringIterator next];

    NSInteger result = 0;

    while (component && character) {

        if (![component canPassCharacter:character]) {
            character = [stringIterator next];
            if ([self index:(stringIterator.index - 1) isInRange:range]) result--;
            continue;
        }

        if ([[component prefixPassingCharacter:character] length]) {
            component = [component passCharacter:character];
            if ([self index:(stringIterator.index - 1) isInRange:range]) result++;
            continue;
        }

        BOOL variable = component.variable;
        BOOL ownSymbol = [component isOwnCharacter:character];
        component = [component passCharacter:character];

        if (!variable) {
            character = [stringIterator next];
        } else if (ownSymbol) {
            character = [stringIterator next];
        }
    }

    return result;
}

- (BOOL)index:(NSInteger)index isInRange:(NSRange)range
{
    return index >= range.location && index <= range.location + range.length;
}

@end
