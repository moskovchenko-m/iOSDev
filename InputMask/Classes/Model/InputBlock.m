//
//  InputBlock.m
//  InputMask
//
//  Created by Egor Taflanidi on 07/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "InputBlock.h"

@interface InputBlock ()
@property (nonatomic, copy) NSString *format;
@property (nonatomic, assign) NSRange range;
@end

@implementation InputBlock

- (instancetype)initWithFormat:(NSString *)format
                         range:(NSRange)range
{
    self = [super init];
    if (self) {
        self.format = [format copy];
        self.range = range;
    }

    return self;
}

+ (instancetype)blockWithFormat:(NSString *)format
                          range:(NSRange)range
{
    return [[self alloc] initWithFormat:format range:range];
}

@end
