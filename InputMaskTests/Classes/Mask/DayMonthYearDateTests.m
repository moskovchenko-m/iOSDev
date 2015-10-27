//
//  DayMonthYearDateTests.m
//  InputMask
//
//  Created by Egor Taflanidi on 10/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskTestCase.h"

@interface DayMonthYearDateTests : MaskTestCase
@end

@implementation DayMonthYearDateTests

- (NSString *)maskFormat
{
    return @"[00]{.}[00]{.}[0000]";
}

- (void)testPlaceholder
{
    XCTAssertEqualObjects([self.mask placeholder], @"01.01.0123");
}

- (void)testSimplePlaceholder
{
    self.mask.placeholderFormat = kMaskPlaceholderFormatSimple;
    XCTAssertEqualObjects([self.mask placeholder], @"00.00.0000");
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

- (void)testApply_12Point_remainedSame
{
    NSString *input = @"12.";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12Point3_remainedSame
{
    NSString *input = @"12.3";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12Point34_remainedSame
{
    NSString *input = @"12.34";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12Point34Point_remainedSame
{
    NSString *input = @"12.34.";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12Point34Point5_remainedSame
{
    NSString *input = @"12.34.5";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12Point34Point56_remainedSame
{
    NSString *input = @"12.34.56";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12Point34Point567_remainedSame
{
    NSString *input = @"12.34.567";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12Point34Point5678_remainedSame
{
    NSString *input = @"12.34.5678";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12Point34Point56789_trimmedTo12Point34Point5678
{
    NSString *input = @"12.34.56789";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12.34.5678", output);
}

- (void)testApply_123_returned12Point3
{
    NSString *input = @"123";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12.3", output);
}

- (void)testApply_1234_returned12Point34
{
    NSString *input = @"1234";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12.34", output);
}

- (void)testApply_12345_returned12Point34Point5
{
    NSString *input = @"12345";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12.34.5", output);
}

- (void)testApply_123456_returned12Point34Point56
{
    NSString *input = @"123456";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12.34.56", output);
}

- (void)testApply_1234567_returned12Point34Point567
{
    NSString *input = @"1234567";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12.34.567", output);
}

- (void)testApply_12345678_returned12Point34Point5678
{
    NSString *input = @"12345678";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12.34.5678", output);
}

- (void)testValue_12Point34Point5678_returned12Point34Point5678
{
    NSString *input = @"12.34.5678";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"12.34.5678", output);
}

- (void)testValue_12Point34Point56_returned12Point34Point56
{
    NSString *input = @"12.34.56";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"12.34.56", output);
}

- (void)testValue_12Point34Point_returned12Point34Point
{
    NSString *input = @"12.34.";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"12.34.", output);
}

- (void)testValue_12Point3_returned12Point3
{
    NSString *input = @"12.3";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"12.3", output);
}

- (void)testValue_12_returned12
{
    NSString *input = @"12";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"12", output);
}

@end
