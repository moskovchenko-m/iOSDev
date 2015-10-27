//
//  NSArrayCycleIterator.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "NSArrayCycleIterator.h"

@interface NSArrayCycleIterator ()

@property (nonatomic, copy) NSArray *array;
@property (nonatomic, assign) NSUInteger index;

@end

@implementation NSArrayCycleIterator

#pragma mark - Конструкторы

- (instancetype)init
{
    if (self = [super init]) {
        self.array = [NSArray array];
        self.index = 0;
    }
    
    return self;
}

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        self.array = array;
        self.index = 0;
    }

    return self;
}

+ (instancetype)iteratorWithArray:(NSArray *)array
{
    return [[self alloc] initWithArray:array];
}

#pragma mark - Публичные методы

- (id)next
{
    if (self.index >= [self.array count]) self.index = 0;
    return self.array[self.index++];
}

- (void)reset
{
    self.index = 0;
}

@end
