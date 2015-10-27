//
//  InputBlock.h
//  InputMask
//
//  Created by Egor Taflanidi on 07/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Модельный объект, представляющий блок пользовательского ввода в форматной 
 строке маски.
 
 Например, для маски
 [000]-[00]
 блоки пользовательского ввода будут:
 @"[000]", location = 0, length = 5;
 @"[00]", location = 6, length = 4
 */
@interface InputBlock : NSObject

/**
 Строка, содержащая символы блока пользовательского ввода.
 */
@property (nonatomic, copy, readonly) NSString *format;

/**
 Диапазон в общей форматной строке маски, который содержит текущий блок 
 пользовательского ввода.
 */
@property (nonatomic, assign, readonly) NSRange range;

/**
 Конструктор.
 Позволяет создать объект-блок пользовательского ввода.
 
 @param format - строка, содержащая символы блока.
 @param range - диапазон блока в общей форматной строке маски.
 
 @return Возвращает инициированный объект типа InputBlock.
 */
- (instancetype)initWithFormat:(NSString *)format
                         range:(NSRange)range;

/**
 Конструктор.
 Позволяет создать объект-блок пользовательского ввода.
 
 @param format - строка, содержащая символы блока.
 @param range - диапазон блока в общей форматной строке маски.
 
 @return Возвращает инициированный объект типа InputBlock.
 */
+ (instancetype)blockWithFormat:(NSString *)format
                          range:(NSRange)range;


@end
