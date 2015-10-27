//
//  NSStringIterator.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 26/02/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Объект-итератор для класса NSString.
 Позволяет посимвольно итерироваться по заданной строке.
 */
@interface NSStringIterator : NSObject

/**
 Строка, по которой проводится итерирование.
 */
@property (nonatomic, copy, readonly) NSString *string;

/**
 Индекс текущего символа.
 
 Текущий символ - этот тот, который будет возвращён методом -next.
 
 Индекс текущего символа для нового итератора будет равен нулю.
 */
@property (nonatomic, assign, readonly) NSUInteger index;

/**
 Конструктор.
 Возвращает итератор для заданной строки.
 
 @param string - строка, по которой нужно итерироваться. Не nil.
 
 @return Возвращает инициированный объект NSStringIterator.
 */
+ (instancetype)iteratorWithString:(NSString *)string;

/**
 Метод для итерации.
 
 @return Возвращает текущий символ и сдвигает итератор на один символ вперёд.
 Если строка закончилась - возвращает nil.
 */
- (NSString *)next;

/**
 Метод для чтения текущего символа без итерирования.
 
 @return Возвращает текущий символ без итерирования. 
 Если строка закончилась - возвращает nil.
 */
- (NSString *)read;

/**
 Обнулить позицию итератора.
 Следующий метод -next будет возвращать первый символ строки.
 */
- (void)reset;

@end
