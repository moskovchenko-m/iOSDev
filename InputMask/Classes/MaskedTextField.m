//
//  MaskedTextField.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 26/02/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskedTextField.h"

#import "Mask.h"
#import "NSStringIterator.h"

@interface MaskedTextField () <UITextFieldDelegate>

@property (nonatomic, strong) Mask *mask;
@property (nonatomic, assign) NSInteger cursorPosition;

@end

@implementation MaskedTextField

#pragma mark - NSObject

- (void)awakeFromNib
{
    [self initialize];
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initialize];
    }
    
    return self;
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    
    return self;
}

#pragma mark - Публичные методы

- (void)assignMaskWithFormat:(NSString *)format
{
    [self assignMask:[Mask maskWithFormatString:format]];
}

- (void)assignMask:(Mask *)mask
{
    [self clearText];
    self.mask = mask;
    self.placeholder = [mask placeholder];
}

- (NSString *)value
{
    return [self.mask valueFromText:self.text];
}

- (void)clearText
{
    self.text = @"";
}

- (void)setText:(NSString *)text
{
    if (self.maskingDisabled) {
        [super setText:text];
    } else {
        if (self.text && text) {
            [self textField:self shouldChangeCharactersInRange:NSMakeRange(0, [self.text length]) replacementString:text];
        } else if (text) {
            [self textField:self shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:text];
        }
    }    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
            replacementString:(NSString *)string
{
    if (self.maskingDisabled) return YES;
    
    if ([self isDeletion:range string:string]) {
        [self deleteTextInRange:range];
    } else {
        [self modifyTextInRange:range withString:string];
    }

    [self trimText];

    return NO;
}

#pragma mark - Частные методы

- (void)initialize
{
    super.delegate = self;
    self.maskingDisabled = NO;
    [self assignMask:[Mask emptyMask]];
}

- (BOOL)isDeletion:(NSRange)range
            string:(NSString *)string
{
    return (range.length > 0) && ([string length] == 0);
}

- (void)deleteTextInRange:(NSRange)range
{
    NSString *text = self.text;

    text = [self replaceCharactersInString:text range:range replacementString:@""];
    text = [self.mask apply:text];

    super.text = text;
    self.cursorPosition = range.location;
}

- (void)modifyTextInRange:(NSRange)range
               withString:(NSString *)string
{
    NSString *text = [self replaceCharactersInString:self.text range:range replacementString:string];

    NSInteger predictedCursorPosition = range.location + [string length];
    NSInteger difference = [self.mask differenceInText:text afterFormattingInRange:NSMakeRange(range.location, [string length])];

    super.text = [self.mask apply:text];
    self.cursorPosition = predictedCursorPosition + difference;
}

- (void)trimText
{
    if ([self.text length] <= [self.mask length]) return;

    NSInteger cursorPosition = self.cursorPosition;
    super.text = [self.text substringToIndex:[self.mask length]];
    self.cursorPosition = cursorPosition;
}

- (NSString *)replaceCharactersInString:(NSString *)string
                                  range:(NSRange)range
                      replacementString:(NSString *)replacementString
{
    NSMutableString *modifiedString = [[NSMutableString alloc] initWithString:string];

    if (range.length) {
        [modifiedString replaceCharactersInRange:range withString:replacementString];
    } else {
        [modifiedString insertString:replacementString atIndex:range.location];
    }

    return modifiedString;
}

#pragma mark - Акцессоры и мутаторы

- (void)setCursorPosition:(NSInteger)position
{
    if (position < 0 || position > [self.text length]) return;

    UITextPosition *from = [self positionFromPosition:[self beginningOfDocument] offset:position];
    UITextPosition *to = [self positionFromPosition:from offset:0];
    [self setSelectedTextRange:[self textRangeFromPosition:from toPosition:to]];
}

- (NSInteger)cursorPosition
{
    UITextPosition *selectedTextRangeLocation = self.selectedTextRange.start;
    return [self offsetFromPosition:self.beginningOfDocument toPosition:selectedTextRangeLocation];
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    // ничего не делать
}

@end
