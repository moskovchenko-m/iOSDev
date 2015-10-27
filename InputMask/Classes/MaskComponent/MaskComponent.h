//
//  MaskComponent.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 26/02/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TransitionGraph;

/**
 Маскирующий компонент. 
 
 Представляет собой символьный анализатор, обладающий внутренним графом 
 переходов к следующим маскирующим компонентам в зависимости от текущего символа
 строки ввода. 
 
 Переход к следующему маскирующему компоненту может сопровождаться вставкой 
 перед текущим символом префиксов.
 
 Переходы делятся на "свои" и "все остальные".
 
 "Свои" переходы предполагают, как правило, отсутствие подстановки 
 корректирующих префиксов перед символом строки ввода.
 "Свой" переход зарегистрирован в графе переходов под конкретным символом. 
 
 В графе также может присутствовать переход "по умолчанию", отвечающий любому 
 другому незарегистрированному символу - этот переход относится к типу 
 "все остальные".
 
 Ключом к переходу "по умолчанию" служит константа [NSString anyCharacter]. Тем
 не менее, граф возвращает переход "по умолчанию" в ответ на любой 
 незарегистрированный ключ, если переход "по умолчанию" предварительно в граф 
 был занесен.
 
 @see Transition, TransitionGraph
 */
@interface MaskComponent : NSObject

/**
 Индикатор, является ли текущий символом необязательным.
 */
@property (nonatomic, assign, readonly) BOOL variable;

/**
 Конструктор.
 Позволяет создать маскирующий компонент с заданным графом переходов.
 
 @param transitions - граф переходов.
 @param variable - индикатор, является ли текущий символ необязательным.
 
 Примером необязательного символа служит цифра "9" в форматной строке маски 
 ввода. Например, [00999]
 
 @return Возвращает объект типа MaskComponent, инициированный графом переходов и
 индикатором, является ли текущий символ необязательным.
 */
- (instancetype)initWithTransitions:(TransitionGraph *)transitions variable:(BOOL)variable;

/**
 Метод, указывающий, может ли маскирующий компонент обработать текущий символ.
 
 Маскирующий компонент может обработать текущий символ в том случае, если его
 граф переходов содержит переход по ключу, равному текущему символу.
 
 Соответственно, если граф переходов содержит переход "по умолчанию", работающий
 для любого символа, маскирующий компонент может обработать любой символ.
 
 @param character - символ, который необходимо обработать. Не nil.
 
 @return Возвращает ответ, указывающий, может ли маскирующий компонент 
 обработать текущий символ.
 */
- (BOOL)canPassCharacter:(NSString *)character;

/**
 Индикатор, является ли текущий символ значимым для сервера.
 
 Маскирующие компоненты для символов из форматной строки, не включённых в 
 фигурные или квадратные скобки, будут возвращать NO, что свидетельствует о том,
 что данный символ не следует включать в значение передаваемое на сервер.
 
 Так, для маски
 +7 [000]
 символы "+", "7" и пробел - не являются значимыми, их не следует включать в 
 значение, отправляемое на сервер.
 
 @param character - символ, который необходимо обработать. Не nil.
 
 @return Возвращает ответ, является ли текущий символ значимым для сервера.
 */
- (BOOL)characterIsValueable:(NSString *)character;

/**
 Индикатор, говорящий о том, зарегистрирован ли в графе переходов переход для 
 данного конкретного символа, либо будет пременен переход "по умолчанию".
 
 В случае, если граф маскирующего компонента содержит переход "по умолчанию", 
 способный обработать любой символ, данная функция даёт понять, будет ли этот 
 переход применен при обработке символа.
 
 @param character - символ, который необходимо обработать.
 
 @return Возвращает YES в случае, если в графе переходов зарегистрирован переход
 для символа character. Иначе NO.
 */
- (BOOL)isOwnCharacter:(NSString *)character;

/**
 Возвращает маскирующий компонент, к которому ведёт переход, отвечающий текущему
 символу строки ввода.
 
 Если для символа строки ввода не существует перехода, возвращается nil.
 
 @param character - символ строки ввода, который необходимо обработать.
 
 @return Возвращает маскирующий компонент, к которому ведёт переход, отвечающий 
 текущему символу строки ввода. Если такого перехода не существет - возвращает 
 nil.
 */
- (MaskComponent *)passCharacter:(NSString *)character;

/**
 Возвращает префикс, который необходимо вставить перед символом строки ввода при
 переходе к следующему маскирующему компоненту.
 
 В случае, если переход по символу невозможен - возвращается nil.
 
 @param character - символ строки ввода, который необходимо обработать.
 
 @return Возвращает префикс, который необходимо вставить перед символом строки ввода при
 переходе к следующему маскирующему компоненту.
 В случае, если переход по символу невозможен - возвращается nil.
 */
- (NSString *)prefixPassingCharacter:(NSString *)character;

@end