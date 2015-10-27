//
//  Mask.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 26/02/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "Mask.h"

#import "NSStringIterator.h"

#import "MaskComponent.h"

#import "FormatParser.h"
#import "SimplePlaceholderCreator.h"
#import "MaskFormatter.h"
#import "MaskCleaner.h"
#import "MaskValueExtractor.h"
#import "FormatSanitizer.h"
#include "Constants.h"

@interface Mask ()

/**
 Компоненты текущей маски. 
 */
@property (nonatomic, copy) NSArray *components;
@property (nonatomic, copy) NSString *formatString;
@property (nonatomic, strong) FormatParser *parser;

@end

@implementation Mask

#pragma mark - Конструкторы

+ (instancetype)maskWithFormatString:(NSString *)formatString
{
    return [[Mask alloc] initWithFormatString:formatString];
}

+ (instancetype)emptyMask
{
    return [Mask maskWithFormatString:@""];
}

- (instancetype)init
{
    return [self initWithFormatString:@""];
}

- (instancetype)initWithFormatString:(NSString *)formatString
{
    if (self = [super init]) {
        self.placeholderFormat = kMaskPlaceholderFormatDefault;
        
        self.parser = [[FormatParser alloc] init];
        self.formatString = [[FormatSanitizer sanitizer] sanitizeFormat:formatString];
        self.components = [self.parser componentsFromFormatString:self.formatString];
    }

    return self;
}

#pragma mark - Публичные методы

- (NSString *)apply:(NSString *)text
{
    text = [self formatText:text];
    text = [self cleanText:text];

    return text;
}

- (NSUInteger)length
{
    return [self countSymbolsInStaticBlocks:self.formatString]
         + [self countSymbolsInInputBlocks:self.formatString]
         + [self countFreeSymbols:self.formatString];
}

- (NSString *)placeholder
{
    switch (self.placeholderFormat) {
        case kMaskPlaceholderFormatDefault:
            return [[PlaceholderCreator formatter] placeholderTextForFormatString:self.formatString];
            
        case kMaskPlaceholderFormatSimple:
            return [[SimplePlaceholderCreator formatter] placeholderTextForFormatString:self.formatString];
    }
}

- (NSString *)valueFromText:(NSString *)text
{
    return [[MaskValueExtractor utilWithFirstComponent:[self firstComponent]] extractValue:text];
}

- (NSInteger)differenceInText:(NSString *)text
       afterFormattingInRange:(NSRange)range
{
    return [[MaskFormatter utilWithFirstComponent:[self firstComponent]] differenceInText:text afterFormattingInRange:range];
}

#pragma mark - Частные методы

- (NSString *)formatText:(NSString *)text
{
    return [[MaskFormatter utilWithFirstComponent:[self firstComponent]] formatText:text];
}

- (NSString *)cleanText:(NSString *)text
{
    return [[MaskCleaner utilWithFirstComponent:[self firstComponent]] cleanText:text];
}

- (NSUInteger)countSymbolsInStaticBlocks:(NSString *)formatString
{
    return [self countSymbolsIn:formatString between:StaticBlockBeginString and:StaticBlockEndString];
}

- (NSUInteger)countSymbolsInInputBlocks:(NSString *)formatString
{
    return [self countSymbolsIn:formatString between:InputBlockBeginString and:InputBlockEndString];
}

- (NSUInteger)countSymbolsIn:(NSString *)string
                     between:(NSString *)leftSymbol
                         and:(NSString *)rightSymbol
{
    NSInteger shouldCount = 0;
    NSUInteger count = 0;

    NSStringIterator *iterator = [NSStringIterator iteratorWithString:string];
    NSString *character = nil;

    while ((character = [iterator next])) {
        shouldCount -= [character isEqualToString:rightSymbol] ? 1 : 0;
        count += shouldCount > 0 ? 1 : 0;
        shouldCount += [character isEqualToString:leftSymbol] ? 1 : 0;
    }

    return count;
}

- (NSUInteger)countFreeSymbols:(NSString *)string
{
    NSInteger shouldCount = 0;
    NSUInteger count = 0;

    NSStringIterator *iterator = [NSStringIterator iteratorWithString:string];
    NSString *character = nil;

    while ((character = [iterator next])) {
        shouldCount -= [character isEqualToString:StaticBlockBeginString] ? 1 : 0;
        shouldCount -= [character isEqualToString:InputBlockBeginString] ? 1 : 0;

        count += shouldCount >= 0 ? 1 : 0;

        shouldCount += [character isEqualToString:StaticBlockEndString] ? 1 : 0;
        shouldCount += [character isEqualToString:InputBlockEndString] ? 1 : 0;
    }

    return count;
}

- (MaskComponent *)firstComponent
{
    return [self.components firstObject];
}

@end
