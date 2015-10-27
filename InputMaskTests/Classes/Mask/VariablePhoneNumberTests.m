//
//  VariablePhoneNumberTests.m
//  InputMask
//
//  Created by Egor Taflanidi on 08/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskTestCase.h"

@interface VariablePhoneNumberTests : MaskTestCase
@end

@implementation VariablePhoneNumberTests

- (NSString *)maskFormat
{
    return @"[000009999999]";
}

- (void)testPlaceholder
{
    XCTAssertEqualObjects([self.mask placeholder], @"012345678901");
}

- (void)testSimplePlaceholder
{
    self.mask.placeholderFormat = kMaskPlaceholderFormatSimple;
    XCTAssertEqualObjects([self.mask placeholder], @"00000");
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

- (void)testApply_123_remainedSame
{
    NSString *input = @"123";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_1234_remainedSame
{
    NSString *input = @"1234";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12345_remainedSame
{
    NSString *input = @"12345";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_123456_remainedSame
{
    NSString *input = @"123456";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_1234567_remainedSame
{
    NSString *input = @"1234567";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12345678_remainedSame
{
    NSString *input = @"12345678";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_123456789_remainedSame
{
    NSString *input = @"123456789";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_1234567890_remainedSame
{
    NSString *input = @"1234567890";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_12345678901_remainedSame
{
    NSString *input = @"12345678901";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_123456789012_remainedSame
{
    NSString *input = @"123456789012";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_1234567890123_trimmedTo123456789012
{
    NSString *input = @"1234567890123";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"123456789012", output);
}

- (void)testApply_12345678901a_returned12345678901
{
    NSString *input = @"12345678901a";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12345678901", output);
}

- (void)testApply_12345a78901a_returned1234578901
{
    NSString *input = @"12345a78901a";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"1234578901", output);
}

- (void)testApply_12345a78a01a_returned123457801
{
    NSString *input = @"12345a78a01a";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"123457801", output);
}

- (void)testApply_12a45a78a01a_returned12457801
{
    NSString *input = @"12a45a78a01a";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12457801", output);
}

- (void)testApply_a2a45a78a01a_returned2457801
{
    NSString *input = @"a2a45a78a01a";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"2457801", output);
}

- (void)testValue_123456789012_123456789012
{
    NSString *input = @"123456789012";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"123456789012", output);
}

- (void)testValue_12345678901_12345678901
{
    NSString *input = @"12345678901";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"12345678901", output);
}

- (void)testValue_123_123
{
    NSString *input = @"123";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"123", output);
}

@end
