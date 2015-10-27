//
//  MonthYearDateTests.m
//  InputMask
//
//  Created by Egor Taflanidi on 08/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskTestCase.h"

@interface MonthYearDateTests : MaskTestCase
@end

@implementation MonthYearDateTests

- (NSString *)maskFormat
{
    return @"[00]{/}[0000]";
}

- (void)testPlaceholder
{
    XCTAssertEqualObjects([self.mask placeholder], @"01/0123");
}

- (void)testSimplePlaceholder
{
    self.mask.placeholderFormat = kMaskPlaceholderFormatSimple;
    XCTAssertEqualObjects([self.mask placeholder], @"00/0000");
}

- (void)testApply_1_remainedSame
{
    NSString *input = @"1";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12_remainedSame
{
    NSString *input = @"12";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12Slash_remainedSame
{
    NSString *input = @"12/";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12Slash3_remainedSame
{
    NSString *input = @"12/3";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12Slash34_remainedSame
{
    NSString *input = @"12/34";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12Slash345_remainedSame
{
    NSString *input = @"12/345";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12Slash3456_remainedSame
{
    NSString *input = @"12/3456";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_delete2_returned13Slash456
{
    NSString *input = @"1/3456";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"13/456", output);
}

- (void)testApply_1a2Slash3456_returned12Slash3456
{
    NSString *input = @"1a2/3456";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12/3456", output);
}

- (void)testApply_1aSlash3456_returned13Slash456
{
    NSString *input = @"1a/3456";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"13/456", output);
}

- (void)testApply_12Slasha456_returned12Slash456
{
    NSString *input = @"12/a456";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12/456", output);
}

- (void)testApply_123_12Slash3
{
    NSString *input = @"123";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12/3", output);
}

- (void)testApply_1234_12Slash34
{
    NSString *input = @"1234";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12/34", output);
}

- (void)testValue_12Slash3456_12Slash3456
{
    NSString *input = @"12/3456";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"12/3456", output);
}

- (void)testValue_12Slash345_12Slash345
{
    NSString *input = @"12/345";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"12/345", output);
}

- (void)testValue_12Slash3_12Slash3
{
    NSString *input = @"12/3";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"12/3", output);
}

- (void)testValue_12Slash_12Slash
{
    NSString *input = @"12/";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"12/", output);
}

- (void)testValue_12_12
{
    NSString *input = @"12";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"12", output);
}

- (void)testValue_1_1
{
    NSString *input = @"1";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"1", output);
}

@end
