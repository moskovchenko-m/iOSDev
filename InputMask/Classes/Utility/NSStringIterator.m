//
//  NSStringIterator.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 26/02/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "NSStringIterator.h"

@interface NSStringIterator ()

@property(nonatomic, copy) NSString *string;
@property(nonatomic, assign) NSUInteger index;

@end

@implementation NSStringIterator

#pragma mark - Конструкторы

+ (instancetype)iteratorWithString:(NSString *)string
{
    return [[NSStringIterator alloc] initWithString:string];
}

- (instancetype)initWithString:(NSString *)string
{
    if (self = [super init]) {
        self.string = string;
        self.index = 0;
    }

    return self;
}

#pragma mark - Публичные методы

- (NSString *)next
{
    if ([self indexIsInvalid]) return nil;
    return [self.string substringWithRange:NSMakeRange(self.index++, 1)];
}

- (NSString *)read
{
    if ([self indexIsInvalid]) return nil;
    return [self.string substringWithRange:NSMakeRange(self.index, 1)];
}

- (void)reset
{
    self.index = 0;
}

#pragma mark - Частные методы

- (BOOL)indexIsInvalid
{
    return (self.index >= [self.string length]);
}

@end
