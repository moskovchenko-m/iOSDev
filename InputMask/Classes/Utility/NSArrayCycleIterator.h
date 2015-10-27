//
//  NSArrayCycleIterator.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Циклический итератор для массивов.
 
 Если в ходе итераций объекты в массиве закончатся, итератор автоматически 
 начнёт перебор с начала.
 */
@interface NSArrayCycleIterator : NSObject

/**
 Конструктор. Позволяет создать итератор для массива array.
 
 @param array - массив, по которому следует итерироваться. Не nil.
 
 @return Возвращает инициированный объект типа NSArrayCycleIterator.
 */
- (instancetype)initWithArray:(NSArray *)array;

/**
 Конструктор. Позволяет создать итератор для массива array.
 
 @param array - массив, по которому следует итерироваться. Не nil.
 
 @return Возвращает инициированный объект типа NSArrayCycleIterator.
 */
+ (instancetype)iteratorWithArray:(NSArray *)array;

/**
 Метод для итерации.
 
 @return Возвращает текущий элемент массива.
 Если в ходе итераций объекты в массиве закончатся, итератор автоматически 
 начнёт перебор с начала.
 */
- (id)next;

/**
Обнулить позицию итератора.
Следующий метод -next будет возвращать первый элемент массива.
*/
- (void)reset;

@end
