//
//  Constants.h
//  InputMask
//
//  Created by Egor Taflanidi on 07/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Файл констант библиотеки.
 Содержит символы, используемые при составлении форматной строки маски.
 */

static const unichar InputBlockBegin = '[';
static const unichar InputBlockEnd = ']';

static NSString * const InputBlockBeginString = @"[";
static NSString * const InputBlockEndString = @"]";

static const unichar StaticBlockBegin = '{';
static const unichar StaticBlockEnd = '}';

static NSString * const StaticBlockBeginString = @"{";
static NSString * const StaticBlockEndString = @"}";

static const unichar RequiredNumber = '0';
static const unichar RequiredLetter = 'A';
static const unichar RequiredSymbol = '_';

static const unichar OptionalNumber = '9';
static const unichar OptionalLetter = 'a';
static const unichar OptionalSymbol = '-';