//
//  MaskUtil.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskUtil.h"

@interface MaskUtil ()
@property (nonatomic, strong) MaskComponent *firstComponent;
@end

@implementation MaskUtil

- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException 
                                   reason:@"Not implemented" 
                                 userInfo:nil];
}

- (instancetype)initWithFirstComponent:(MaskComponent *)firstComponent
{
    self = [super init];
    if (self) {
        self.firstComponent = firstComponent;
    }

    return self;
}

+ (instancetype)utilWithFirstComponent:(MaskComponent *)firstComponent
{
    return [[self alloc] initWithFirstComponent:firstComponent];
}

@end
