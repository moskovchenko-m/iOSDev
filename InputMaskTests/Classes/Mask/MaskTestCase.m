//
//  MaskTestCase.m
//  InputMask
//
//  Created by Egor Taflanidi on 07/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskTestCase.h"

@interface MaskTestCase ()
@property (nonatomic, strong) Mask *mask;
@end

@implementation MaskTestCase

- (void)setUp
{
    [super setUp];
    self.mask = [Mask maskWithFormatString:[self maskFormat]];
}

- (void)tearDown
{
    self.mask = nil;
    [super tearDown];
}

- (NSString *)maskFormat
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException 
                                   reason:@"Abstract method" 
                                 userInfo:nil];
}

@end
