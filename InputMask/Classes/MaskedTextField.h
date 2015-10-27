//
//  MaskedTextField.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 26/02/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Mask;

/**
 Текстовое поле с применением маскирования.
 
 Маскирование может быть задано посредством объекта класса Mask, а также 
 через форматную строку. Например: +7 ([000]) [000] [00] [00]
 Во втором случае объект класса Mask генерируется на основании предоставленной
 форматной строки.
 
 Текстовое поле ограничивает ввод пользователя по количеству символов,
 обрабатываемых маской. Любой символ, выходящий за этот предел - обрезается.
 
 Так, для строки
 +7 (123) 456 78 90
 если пользователь введёт ещё одну семёрку перед цифрой шесть, в поле останется:
 +7 (123) 457 67 89
 Символ "0" будет обрезан.
 
 @see Mask
 */
@interface MaskedTextField : UITextField

/**
 Отключить маскирование.
 */
@property (nonatomic, assign) BOOL maskingDisabled;

/**
 Задать текстовому полю формат маски ввода.
 
 @param format - строка-формат маски ввода. Не nil.
 Например: +7 ([000]) [000] [00] [00]
 */
- (void)assignMaskWithFormat:(NSString *)format;

/**
 Задать текстовому полю маску ввода.
 
 @param mask - маска, форматирующая ввод. Не nil.
 */
- (void)assignMask:(Mask *)mask;

/**
 Метод для получения строки из значимых символов, экстрагированных на основании
 маски ввода.
 
 Например, при формате маски
 +7 ([000]) [000] [00] [00]
 из строки
 +7 (123) 456 78 90
 данным методом будут получены символы
 1234567890
 
 @return Возвращает строку из значимых символов, экстрагированных на основании
 маски ввода.
 */
- (NSString *)value;

/**
 Очистить поле ввода.
 */
- (void)clearText;

@end
