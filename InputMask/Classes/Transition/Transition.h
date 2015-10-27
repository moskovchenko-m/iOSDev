//
//  Transition.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 26/02/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MaskComponent;

/**
 Объект-переход.
 
 Каждый маскирующий элемент (MaskComponent или наследник) включает в себя набор
 переходов, каждый из которых приводит к следующему маскирующему элементу.
 Ключом к переходу служит символ из строки, введенной пользователем.
 
 Так, у маски ввода может быть маскирующий элемент, включающий в себя переходы 
 исключительно по цифрам. Данный маскирующий элемент относится ко второму 
 символу в строке ввода. Соответственно, если пользователь введёт строку "1а", 
 то второй символ "а" будет проигнорирован и стёрт.
 
 @see TransitionGraph
 */
@interface Transition : NSObject

/**
 Следующий маскирующий элемент, к которому ведёт данный переход.
 */
@property(nonatomic, strong, readonly) MaskComponent *target;

/**
 Префикс, который необходимо вставить перед символом-ключом перехода в строке
 ввода.
 */
@property(nonatomic, strong, readonly) NSString *prefix;

/**
 Индикатор, является ли текущий символ значимым для сервера или нет.
 Значимыми символами по умолчанию являются символы, заключённые в квадратные или
 фигурные скобки в форматной строке маски ввода.
 */
@property(nonatomic, assign, readonly) BOOL valueable;

/**
 Конструктор.
 
 Позволяет создать переход к следующему маскирующему элементу.
 
 @param target - следующий маскирующий элемент. Не nil.
 @param prefix - префикс перехода. Может быть пустой строкой. Не nil.
 @param valueable - индикатор, является ли символ, приводящий к данному 
 переходу, значимым для сервера.
 
 @return Возвращает инициированный объект Transition.
 */
- (instancetype)initWithTarget:(MaskComponent *)target
                        prefix:(NSString *)prefix
                     valueable:(BOOL)valueable;

/**
 Конструктор.
 
 Позволяет создать переход к следующему маскирующему элементу.
 
 @param target - следующий маскирующий элемент. Не nil.
 @param prefix - префикс перехода. Может быть пустой строкой. Не nil.
 @param valueable - индикатор, является ли символ, приводящий к данному 
 переходу, значимым для сервера.
 
 @return Возвращает инициированный объект Transition.
 */
+ (instancetype)transitionWithTarget:(MaskComponent *)target
                              prefix:(NSString *)prefix
                           valueable:(BOOL)valueable;


@end
