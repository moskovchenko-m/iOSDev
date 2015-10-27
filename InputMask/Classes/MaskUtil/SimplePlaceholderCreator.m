//
//  SimplePlaceholderCreator.m
//  InputMask
//
//  Created by Egor Taflanidi on 24/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "SimplePlaceholderCreator.h"
#include "Constants.h"

@implementation SimplePlaceholderCreator

#pragma mark - Публичные методы

- (NSString *)placeholderTextForFormatString:(NSString *)formatString
{
    NSString *filledWithData = 
        [self replaceInputCharactersWithMockData:formatString];
    filledWithData = [self removeOptionalCharacters:filledWithData];
    return [self removeBraces:filledWithData];
}

#pragma mark - Приватные методы

- (NSString *)replaceInputCharactersWithMockData:(NSString *)formatString
{
    NSMutableString *result = [formatString mutableCopy];
    NSInteger bracesOpened = 0;
    
    for (NSUInteger index = 0; index < [result length]; index++) {
        unichar character = [result characterAtIndex:index];
        bracesOpened -= character == InputBlockEnd ? 1 : 0;
        
        if (bracesOpened > 0) {
            switch (character) {
                case RequiredNumber: {
                    [result replaceCharactersInRange:NSMakeRange(index, 1) withString:@"0"];
                } break;
                    
                case RequiredSymbol:
                case RequiredLetter: {
                    [result replaceCharactersInRange:NSMakeRange(index, 1) withString:@"A"];
                }
            }
        } 
        
        bracesOpened += character == InputBlockBegin ? 1 : 0;
    }
    
    return result;
}

- (NSString *)removeOptionalCharacters:(NSString *)formatString
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSInteger bracesOpened = 0;
    
    for (NSUInteger index = 0; index < [formatString length]; index++) {
        unichar character = [formatString characterAtIndex:index];
        bracesOpened -= character == InputBlockEnd ? 1 : 0;
        
        if (bracesOpened > 0) {
            switch (character) {
                case OptionalLetter:
                case OptionalSymbol:
                case OptionalNumber: {
                    continue;
                } 
                    
            }
        } 
        
        [result appendFormat:@"%c", character];
        bracesOpened += character == InputBlockBegin ? 1 : 0;
    }
    
    return result;
}

@end
