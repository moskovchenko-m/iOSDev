//
//  PlaceholderCreator.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "NSString+Character.h"
#import "NSArrayCycleIterator.h"
#import "PlaceholderCreator.h"
#include "Constants.h"

static const NSUInteger PlaceholderMaxLength = 25;

@interface PlaceholderCreator ()
@property (nonatomic, strong) NSArrayCycleIterator *numbersIterator;
@property (nonatomic, strong) NSArrayCycleIterator *lettersIterator;
@end

@implementation PlaceholderCreator

#pragma mark - Конструкторы

+ (instancetype)formatter
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.numbersIterator = [NSArrayCycleIterator iteratorWithArray:[NSString numbers]];
        self.lettersIterator = [NSArrayCycleIterator iteratorWithArray:[NSString letters]];
    }

    return self;
}

#pragma mark - Публичные методы

- (NSString *)placeholderTextForFormatString:(NSString *)formatString
{
    NSString *placeholder = [self replaceInputCharactersWithMockData:formatString];
    placeholder = [self removeBraces:placeholder];
    if ([placeholder length] > PlaceholderMaxLength)
        placeholder = [placeholder substringToIndex:PlaceholderMaxLength];
    return placeholder;
}

#pragma mark - Частные методы

- (NSString *)replaceInputCharactersWithMockData:(NSString *)formatString
{
    NSMutableString *result = [formatString mutableCopy];
    NSInteger bracesOpened = 0;

    for (NSUInteger index = 0; index < [result length]; index++) {
        unichar character = [result characterAtIndex:index];
        bracesOpened -= character == InputBlockEnd ? 1 : 0;

        if (bracesOpened > 0) {
            switch (character) {
                case OptionalNumber:
                case RequiredNumber: {
                    [result replaceCharactersInRange:NSMakeRange(index, 1) withString:[self.numbersIterator next]];
                } break;

                case RequiredSymbol:
                case OptionalSymbol:
                case RequiredLetter:
                case OptionalLetter: {
                    [result replaceCharactersInRange:NSMakeRange(index, 1) withString:[self.lettersIterator next]];
                }
            }
        } else {
            [self.numbersIterator reset];
            [self.lettersIterator reset];
        }

        bracesOpened += character == InputBlockBegin ? 1 : 0;
    }

    return result;
}

- (NSString *)removeBraces:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:InputBlockBeginString withString:@""];
    string = [string stringByReplacingOccurrencesOfString:InputBlockEndString withString:@""];
    string = [string stringByReplacingOccurrencesOfString:StaticBlockBeginString withString:@""];
    return   [string stringByReplacingOccurrencesOfString:StaticBlockEndString withString:@""];
}

@end
