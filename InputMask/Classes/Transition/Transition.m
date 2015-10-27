//
//  Transition.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 26/02/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "Transition.h"
#import "MaskComponent.h"

@interface Transition ()

@property(nonatomic, strong) MaskComponent *target;
@property(nonatomic, strong) NSString *prefix;
@property(nonatomic, assign) BOOL valueable;

@end

@implementation Transition

- (instancetype)initWithTarget:(MaskComponent *)target
                        prefix:(NSString *)prefix
                     valueable:(BOOL)valueable
{
    self = [super init];
    if (self) {
        self.target = target;
        self.prefix = prefix;
        self.valueable = valueable;
    }

    return self;
}

+ (instancetype)transitionWithTarget:(MaskComponent *)target
                              prefix:(NSString *)prefix
                           valueable:(BOOL)valueable
{
    return [[self alloc] initWithTarget:target
                                 prefix:prefix
                              valueable:valueable];
}


@end
