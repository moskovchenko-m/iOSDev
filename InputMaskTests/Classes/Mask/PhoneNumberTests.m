//
//  PhoneNumberTests.m
//  InputMask
//
//  Created by Egor Taflanidi on 07/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskTestCase.h"

@interface PhoneNumberTests : MaskTestCase
@end

@implementation PhoneNumberTests

- (NSString *)maskFormat
{
    return @"+7 ([000]) [000] [00] [00]";
}

- (void)testPlaceholder
{
    XCTAssertEqualObjects([self.mask placeholder], @"+7 (012) 012 01 01");
}

- (void)testSimplePlaceholder
{
    self.mask.placeholderFormat = kMaskPlaceholderFormatSimple;
    XCTAssertEqualObjects([self.mask placeholder], @"+7 (000) 000 00 00");
}

- (void)testApply_plus_remainedSame
{
    NSString *input = @"+";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7_remainedSame
{
    NSString *input = @"+7";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7Space_remainedSame
{
    NSString *input = @"+7 ";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket_remainedSame
{
    NSString *input = @"+7 (";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket1_remainedSame
{
    NSString *input = @"+7 (1";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket12_remainedSame
{
    NSString *input = @"+7 (12";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket123_remainedSame
{
    NSString *input = @"+7 (123";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket123Bracket_remainedSame
{
    NSString *input = @"+7 (123)";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket123BracketSpace_remainedSame
{
    NSString *input = @"+7 (123) ";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket123BracketSpace4_remainedSame
{
    NSString *input = @"+7 (123) 4";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket123BracketSpace45_remainedSame
{
    NSString *input = @"+7 (123) 45";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket123BracketSpace456_remainedSame
{
    NSString *input = @"+7 (123) 456";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket123BracketSpace456Space_remainedSame
{
    NSString *input = @"+7 (123) 456 ";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket123BracketSpace456Space7_remainedSame
{
    NSString *input = @"+7 (123) 456 7";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket123BracketSpace456Space78_remainedSame
{
    NSString *input = @"+7 (123) 456 78";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket123BracketSpace456Space78Space_remainedSame
{
    NSString *input = @"+7 (123) 456 78 ";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket123BracketSpace456Space78Space9_remainedSame
{
    NSString *input = @"+7 (123) 456 78 9";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_plus7SpaceBracket123BracketSpace456Space78Space90_remainedSame
{
    NSString *input = @"+7 (123) 456 78 90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(input, output);
}

- (void)testApply_7_returnedPlus7
{
    NSString *input = @"7";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7", output);
}

- (void)testApply_space_returnedPlus7Space
{
    NSString *input = @" ";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 ", output);
}

- (void)testApply_bracket_returnedPlus7SpaceBracket
{
    NSString *input = @"(";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (", output);
}

- (void)testApply_1_returnedPlus7SpaceBracket1
{
    NSString *input = @"1";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (1", output);
}

- (void)testApply_rightBracket_returnedPlus7SpaceBracket
{
    NSString *input = @")";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (", output);
}

- (void)testApply_a_returnedPlus7SpaceBracket
{
    NSString *input = @"a";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (", output);
}

- (void)testApply_1234567890_returnedPlus7SpaceBracket123BracketSpace456Space78Space90
{
    NSString *input = @"1234567890";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (123) 456 78 90", output);
}

- (void)testApply_bracket123Bracket456Dash78Dash90_returnedPlus7SpaceBracket123BracketSpace456Space78Space90
{
    NSString *input = @"(123)456-78-90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (123) 456 78 90", output);
}

- (void)testApply_8bracket123Bracket456Dash78Dash90_returnedPlus7SpaceBracket812BracketSpace345Space67Space89
{
    NSString *input = @"8(123)456-78-90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (812) 345 67 89", output);
}

- (void)testApply_delete3_returnedPlus7SpaceBracket124BracketSpace567Space89Space0
{
    NSString *input = @"+7 (12) 456 78 90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (124) 567 89 0", output);
}

- (void)testApply_delete1_returnedPlus7SpaceBracket234BracketSpace567Space89Space0
{
    NSString *input = @"+7 (23) 456 78 90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (234) 567 89 0", output);
}

- (void)testApply_delete4_returnedPlus7SpaceBracket123BracketSpace567Space89Space0
{
    NSString *input = @"+7 (123) 56 78 90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (123) 567 89 0", output);
}

- (void)testApply_delete5_returnedPlus7SpaceBracket123BracketSpace467Space89Space0
{
    NSString *input = @"+7 (123) 46 78 90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (123) 467 89 0", output);
}

- (void)testApply_delete6_returnedPlus7SpaceBracket123BracketSpace457Space89Space0
{
    NSString *input = @"+7 (123) 45 78 90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (123) 457 89 0", output);
}

- (void)testApply_delete7_returnedPlus7SpaceBracket123BracketSpace456Space89Space0
{
    NSString *input = @"+7 (123) 456 8 90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (123) 456 89 0", output);
}

- (void)testApply_delete8_returnedPlus7SpaceBracket123BracketSpace456Space79Space0
{
    NSString *input = @"+7 (123) 456 7 90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (123) 456 79 0", output);
}

- (void)testApply_delete9_returnedPlus7SpaceBracket123BracketSpace456Space78Space0
{
    NSString *input = @"+7 (123) 456 78 0";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (123) 456 78 0", output);
}

- (void)testApply_delete0_returnedPlus7SpaceBracket123BracketSpace456Space78Space9
{
    NSString *input = @"+7 (123) 456 78 9";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (123) 456 78 9", output);
}

- (void)testApply_deleteSpace78Space_returnedPlus7SpaceBracket123BracketSpace456Space90
{
    NSString *input = @"+7 (123) 45690";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (123) 456 90", output);
}

- (void)testApply_delete3Bracket45_returnedPlus7SpaceBracket126BracketSpace789Space0
{
    NSString *input = @"+7 (126 78 90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (126) 789 0", output);
}

- (void)testApply_replace23_8a8_returnedPlus7SpaceBracket188BracketSpace456Space78Space90
{
    NSString *input = @"+7 (18a8) 456 78 90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (188) 456 78 90", output);
}

- (void)testApply_replace23_a8a8a_returnedPlus7SpaceBracket188BracketSpace456Space78Space90
{
    NSString *input = @"+7 (1a8a8a) 456 78 90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (188) 456 78 90", output);
}

- (void)testApply_replace23_aaa_returnedPlus7SpaceBracket145BracketSpace678Space90
{
    NSString *input = @"+7 (1aaa) 456 78 90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (145) 678 90", output);
}

- (void)testApply_replace23BracketSpace45_aaabbbccc_returnedPlus7SpaceBracket167BracketSpace890
{
    NSString *input = @"+7 (1aaabbbccc6 78 90";
    NSString *output = [self.mask apply:input];
    XCTAssertEqualObjects(@"+7 (167) 890", output);
}

- (void)testValue_plus7SpaceBracket123BracketSpace456Space78Space90_1234567890
{
    NSString *input = @"+7 (123) 456 78 90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"1234567890", output);
}

- (void)testValue_plus7Bracket123BracketSpace456Space78Space90_1234567890
{
    NSString *input = @"+7(123) 456 78 90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"1234567890", output);
}

- (void)testValue_plus7SpaceBracket123Bracket456Space78Space90_1234567890
{
    NSString *input = @"+7 (123)456 78 90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"1234567890", output);
}

- (void)testValue_plus7Bracket123Bracket456Space78Space90_1234567890
{
    NSString *input = @"+7(123)456 78 90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"1234567890", output);
}

- (void)testValue_plus7Bracket123Bracket45678Space90_1234567890
{
    NSString *input = @"+7(123)45678 90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"1234567890", output);
}

- (void)testValue_plus7SpaceBracket124BracketSpace567Space89Space0_124567890
{
    NSString *input = @"+7 (124) 567 89 0";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"124567890", output);
}

- (void)testValue_plus7SpaceBracket124BracketSpace578Space90_12457890
{
    NSString *input = @"+7 (124) 578 90";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"12457890", output);
}

- (void)testValue_plus7SpaceBracket124BracketSpace57_12457
{
    NSString *input = @"+7 (124) 57";
    NSString *output = [self.mask valueFromText:input];
    XCTAssertEqualObjects(@"12457", output);
}

@end
