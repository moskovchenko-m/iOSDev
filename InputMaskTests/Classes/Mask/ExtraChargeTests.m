//
//  ExtraChargeTests.m
//  InputMask
//
//  Created by Egor Taflanidi on 10/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskTestCase.h"

@interface ExtraChargeTests : MaskTestCase
@end

@implementation ExtraChargeTests

- (NSString *)maskFormat
{
    return @"[9999999990]{.}[00]";
}

- (void)testPlaceholder
{
    XCTAssertEqualObjects([self.mask placeholder], @"0123456789.01");
}

- (void)testSimplePlaceholder
{
    self.mask.placeholderFormat = kMaskPlaceholderFormatSimple;
    XCTAssertEqualObjects([self.mask placeholder], @"0.00");
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

- (void)testApply_1234567890Point1_remainedSame
{
    NSString *input = @"1234567890.1";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_1234567890Point12_remainedSame
{
    NSString *input = @"1234567890.12";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_234567890Point12_remainedSame
{
    NSString *input = @"234567890.12";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_34567890Point12_remainedSame
{
    NSString *input = @"34567890.12";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_4567890Point12_remainedSame
{
    NSString *input = @"4567890.12";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_567890Point12_remainedSame
{
    NSString *input = @"567890.12";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_67890Point12_remainedSame
{
    NSString *input = @"67890.12";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_7890Point12_remainedSame
{
    NSString *input = @"7890.12";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_890Point12_remainedSame
{
    NSString *input = @"890.12";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_90Point12_remainedSame
{
    NSString *input = @"90.12";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_0Point12_remainedSame
{
    NSString *input = @"0.12";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_Point12_returned12
{
    NSString *input = @".12";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12", output);
}

- (void)testApply_0Point1_remainedSame
{
    NSString *input = @"0.1";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_0Point_remainedSame
{
    NSString *input = @"0.";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_1234567890Point123_trimmedTo1234567890Point12
{
    NSString *input = @"1234567890.123";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"1234567890.12", output);
}

- (void)testApply_12345678901_returned1234567890Point1
{
    NSString *input = @"12345678901";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"1234567890.1", output);
}

- (void)testApply_123456789012_returned1234567890Point12
{
    NSString *input = @"123456789012";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"1234567890.12", output);
}

- (void)testApply_1234Point56789012_trimmedTo1234Point56
{
    NSString *input = @"1234.5678901";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"1234.56", output);
}

- (void)testApply_1234a5678_returned1234Point56
{
    NSString *input = @"1234a5678";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"1234.56", output);
}

- (void)testApply_12a34a5678_returned12Point34
{
    NSString *input = @"12a34a5678";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"12.34", output);
}

- (void)testValue_1234567890Point12_1234567890Point12
{
    NSString *input = @"1234567890.12";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testValue_1234567890Point1_1234567890Point1
{
    NSString *input = @"1234567890.1";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testValue_1234567890Point_1234567890Point
{
    NSString *input = @"1234567890.";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testValue_1234567890_1234567890
{
    NSString *input = @"1234567890";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testValue_12345678Point90_12345678Point90
{
    NSString *input = @"12345678.90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testValue_1234567Point90_1234567Point90
{
    NSString *input = @"1234567.90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testValue_123456Point90_123456Point90
{
    NSString *input = @"123456.90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testValue_12345Point90_12345Point90
{
    NSString *input = @"12345.90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testValue_1234Point90_1234Point90
{
    NSString *input = @"1234.90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testValue_123Point90_123Point90
{
    NSString *input = @"123.90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testValue_12Point90_12Point90
{
    NSString *input = @"12.90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testValue_1Point90_1Point90
{
    NSString *input = @"1.90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(input, output);
}

@end
