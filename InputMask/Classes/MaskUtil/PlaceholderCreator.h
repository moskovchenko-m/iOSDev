//
//  PlaceholderCreator.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Сущность, генерирующая текст-placeholder для заданной форматной маскирующей
 строки.
 */
@interface PlaceholderCreator : NSObject

/**
 Конструктор.
 
 @return Возвращает объект PlaceholderCreator.
 */
+ (instancetype)formatter;

/**
 Метод, генерирующий текст-placeholder, соответствующий заданной маскирующей
 строке.
 
 @param formatString - строка-формат маски.
 
 Например, для маски в формате
 +7 ([000]) [000] [00] [00]
 будет сгенерирован placeholder:
 +7 (012) 345 67 89
 
 @return Возвращает текст-placeholder, соответствующий заданной маскирующей
 строке.
 */
- (NSString *)placeholderTextForFormatString:(NSString *)formatString;

/**
 Убрать все форматирующие скобки (квадратные и фигурные).
 ("protected"-метод)
 
 @param string - строка, в которой нужно убрать скобки. Не nil.
 
 @return Возвращает строку без форматирующих скобок.
 */
- (NSString *)removeBraces:(NSString *)string;

@end
