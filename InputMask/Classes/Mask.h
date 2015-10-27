//
//  Mask.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 26/02/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Формат placeholder'a.
 */
typedef NS_ENUM(NSUInteger, MaskPlaceholderFormat){
    /**
     Простой формат.
     
     +7 ([000]) [000] [00] [009] => +7 (000) 000 00 00
     [A________________________] => A
     */
    kMaskPlaceholderFormatSimple,
    
    /**
     Формат по умолчанию.
     
     +7 ([000]) [000] [00] [009] => +7 (012) 345 67 890
     [A________________________] => АБВГДЕЁЖЗИКЛМНОПРСТУФХЦЧШ
     */
    kMaskPlaceholderFormatDefault
};

/**
 Маска для текста.
 
 Механизм применения маски включает последовательный анализ символов текста.
 
 Маска включает в себя граф маскирующих компонентов, каждый из которых 
 декларирует, является ли текущий символ значимым, какой символ должен 
 следовать за ним, а также что должно происходить, если текущий символ не 
 соответствует формату.
 
 Маскирующий компонент - объект класса MaskComponent, либо его наследник.
 @see MaskComponent
 */
@interface Mask : NSObject

/**
 Конструктор.
 Позволяет создать объект Mask, обрабатывающий текст согласно заданному шаблону.
 
 @param formatString - шаблон, согласно которому необходимо сделать маску. 
 Не nil.
 
 Например: 
 +7 ([000]) [000] [00] [00]
 
 @return Возвращает инициированный объект-маску.
 */
+ (instancetype)maskWithFormatString:(NSString *)formatString;

/**
 Конструктор для placeholder'a.
 Создаёт маску, соответствующую пустой форматной строке, позволяющую ввести
 любой символ.
 
 Следует обратить внимание, что метод -length для подобной маски возвращает 
 нулевую длину. 
 
 @return Возвращает маску-placeholder, соответствующую пустой форматной строке.
 */
+ (instancetype)emptyMask;

/**
 Конструктор.
 Позволяет создать объект Mask, обрабатывающий текст согласно заданному шаблону.
 
 @param formatString - шаблон, согласно которому необходимо сделать маску. 
 Не nil.
 
 Например: 
 +7 ([000]) [000] [00] [00]
 
 @return Возвращает инициированный объект-маску.
 */
- (instancetype)initWithFormatString:(NSString *)formatString;

/**
 Применить шаблон форматирования к тексту.
 
 @param text - текст, подлежащий форматированию. Не nil.
 
 @return Возвращает отформатированный текст.
 */
- (NSString *)apply:(NSString *)text;

/**
 Метод, вычисляющий длину строки, на протяжении которой применяется маскирующее
 форматирование.
 
 Предполагается, что длина строки, которую вводит пользователь на экране, 
 не должна превышать данное значение.
 
 @return Возвращает длину строки, на протяжении которой применяется маскирующее
 форматирование.
 */
- (NSUInteger)length;

/**
 Генерирует placeholder, соответствующий шаблону данной маски.
 
 Например, для маски по шаблону
 +7 ([000]) [000] [00] [00]
 будет сгенерирован placeholder:
 +7 (012) 345 67 89
 
 @return Возвращает строку-placeholder, соответствующую шаблону маски.
 */
- (NSString *)placeholder;

/**
 Согласно собственному шаблону экстрагирует из текста значимые символы, которые
 затем можно передать на сервер.
 
 Экстрагирование значения предполагает предварительное форматирование строки.
 Метод обладает определённой степенью "пуленепробоваемости", и сможет корректно
 обработать строки, форматирование которых не совсем соответствует эталону,
 однако консистентность данных для подобного случая не гарантируется.
 
 Например, для маски по шаблону
 +7 ([000]) [000] [00] [00]
 для текста
 +7 (012) 345 67 89
 будет возвращаться значение
 0123456789
 а для текста
 +7 (012) 345 6
 будет возвращаться значение
 0123456
 
 @param text - входной текст, отображаемый на экране и вводимый пользователем.
 Не nil.
 
 @return Возвращает строку значимых символов согласно формату.
 */
- (NSString *)valueFromText:(NSString *)text;

/**
 Метод, подсчитывающий разницу по количеству символов после форматирования 
 строки на определённом диапазоне.
 
 Так, при вставке символов возвращаемое значение увеличивается, при удалении -
 уменьшается.
 
 Например, для маски по шаблону 
 +7 ([000]) [000] [00] [00] 
 при введении числа "8" строка приводится к виду
 +7 (8
 Таким образом, разница составляет +4 символа: "+7 (".
 
 При вставке из буфера обмена значения "8а" строка также приводится к виду
 +7 (8
 Однако, на этот раз разница будет составлять всего +3 символа: 4 символа "+7 ("
 добавилось, один символ "а" - был удалён.
 
 Данный метод предполагается использовать для корректирования положения каретки
 ввода текста. Например, при введении строки "8а" в поле с маской 
 +7 ([000]) [000] [00] [00]
 предполагается, что каретка будет находиться после второго символа. Таким 
 образом, уже после форматирования фокус ввода останется на позиции между 
 семёркой и пробелом, что неправильно.
 Корректировка +3 позволяет сдвинуть каретку на правильную позицию.
 
 @param text - текст, который будет отформатирован. Не nil.
 @param range - диапазон, в котором были внесены изменения.
 
 Пример применения.
 Шаблон: 
 +7 ([000]) [000] [00] [00]
 Строка на экране:
 +7 (123
 Пользователь вводит цифру 4.
 Диапазон изменений: location = 7; length = 1.
 Форматирование:
 +7 (123) 4
 Разница составляет: +2 символа: ")" и пробел.
 
 @return Возвращает разницу по количеству символов после форматирования строки
 на определённом диапазоне.
 */
- (NSInteger)differenceInText:(NSString *)text
       afterFormattingInRange:(NSRange)range;

/**
 Формат placeholder'a.
 @see MaskPlaceholderFormat
 */
@property (nonatomic, assign) MaskPlaceholderFormat placeholderFormat;

@end