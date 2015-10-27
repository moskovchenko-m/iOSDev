//
//  FormatSanitizer.m
//  InputMask
//
//  Created by Egor Taflanidi on 07/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "NSStringIterator.h"
#import "NSString+Character.h"
#import "FormatSanitizer.h"
#include "Constants.h"
#import "InputBlock.h"

@implementation FormatSanitizer

#pragma mark - Конструкторы

+ (instancetype)sanitizer
{
    return [[self alloc] init];
}

#pragma mark - Публичные методы

- (NSString *)sanitizeFormat:(NSString *)format
{
    return [self sortInputBlocks:format];
}

#pragma mark - Частные методы

- (NSString *)sortInputBlocks:(NSString *)format
{
    NSMutableString *result = [format mutableCopy];

    NSArray *inputBlocks = [self inputBlocksWithFormat:format];
    inputBlocks = [self sortCharactersInBlocks:inputBlocks];

    for (InputBlock *block in inputBlocks) {
        [result replaceCharactersInRange:block.range withString:block.format];
    }

    return result;
}

- (NSArray *)sortCharactersInBlocks:(NSArray *)blocks
{
    NSMutableArray *result = [[NSMutableArray alloc] init];

    for (InputBlock *block in blocks) {
        [result addObject:[InputBlock blockWithFormat:[self sortCharactersInBlockFormat:block.format]
                                                range:block.range]];
    }

    return result;
}

- (NSString *)sortCharactersInBlockFormat:(NSString *)format
{
    format = [self sortNumbersInBlockFormat:format];
    format = [self sortLettersInBlockFormat:format];
    format = [self sortSymbolsInBlockFormat:format];

    return format;
}

- (NSString *)sortSymbolsInBlockFormat:(NSString *)format
{
    return [self simplifiedBubbleSortForString:format
                                 leftCharacter:RequiredSymbol
                                rightCharacter:OptionalSymbol];
}

- (NSString *)sortLettersInBlockFormat:(NSString *)format
{
    return [self simplifiedBubbleSortForString:format
                                 leftCharacter:RequiredLetter
                                rightCharacter:OptionalLetter];
}

- (NSString *)sortNumbersInBlockFormat:(NSString *)format
{
    return [self simplifiedBubbleSortForString:format
                                 leftCharacter:RequiredNumber
                                rightCharacter:OptionalNumber];
}

- (NSString *)simplifiedBubbleSortForString:(NSString *)string
                              leftCharacter:(unichar)leftCharacter
                             rightCharacter:(unichar)rightCharacter
{
    NSMutableString *result = [string mutableCopy];

    BOOL finished;
    do {
        finished = YES;

        for (NSUInteger index = 0; index < string.length - 1; index++) {
            unichar character = [result characterAtIndex:index];
            unichar nextCharacter = [result characterAtIndex:index + 1];

            if (character == rightCharacter && nextCharacter == leftCharacter) {
                [self swapCharactersInString:result leftIndex:index rightIndex:index + 1];
                finished = NO;
            }
        }

    } while (!finished);


    return result;
}

- (void)swapCharactersInString:(NSMutableString *)string
                     leftIndex:(NSUInteger)leftIndex
                    rightIndex:(NSUInteger)rightIndex
{
    NSRange leftRange = NSMakeRange(leftIndex, 1);
    NSRange rightRange = NSMakeRange(rightIndex, 1);

    NSString *leftCharacter = [string substringWithRange:leftRange];
    NSString *rightCharacter = [string substringWithRange:rightRange];

    [string replaceCharactersInRange:leftRange withString:rightCharacter];
    [string replaceCharactersInRange:rightRange withString:leftCharacter];
}

- (NSArray *)inputBlocksWithFormat:(NSString *)format
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSStringIterator *iterator = [NSStringIterator iteratorWithString:format];
    NSString *character = [iterator next];

    BOOL isInputBlock = NO; // MARK: Вложенные блоки ввода не поддерживаются
    NSUInteger location = 0;
    NSUInteger length = 0;
    while (character) {
        if ([character isEqualToString:InputBlockBeginString]) {
            isInputBlock = YES;
            location = iterator.index - 1;
        }

        if ([character isEqualToString:InputBlockEndString] && isInputBlock) {
            isInputBlock = NO;

            length = iterator.index - location;
            NSRange range = NSMakeRange(location, length);
            [result addObject:[InputBlock blockWithFormat:[format substringWithRange:range] range:range]];
        }

        character = [iterator next];
    }

    return result;
}

@end
