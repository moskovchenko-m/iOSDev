//
//  MaskValueExtractor.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MaskUtil.h"

@class MaskComponent;

/**
 Утилита, экстрагирующая значимые символы из текста согласно заданному шаблону.
 */
@interface MaskValueExtractor : MaskUtil

/**
 Метод, выделяющий из текста значимые символы согласно заданному шаблону.
 
 @param text - текст, из которого нужно выделить значимые символы. Не nil.
 
 Например, для шаблона
 +7 ([000]) [000] [00] [00]
 из строки
 +7 (123) 456 78 90
 будет получена строка значимых символов
 1234567890
 
 @return Возвращает строку, состояющую из значимых символов, входивших в текст.
 */
- (NSString *)extractValue:(NSString *)text;

@end
