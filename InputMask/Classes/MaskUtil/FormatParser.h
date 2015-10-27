//
//  FormatParser.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Сущность, генерирующая граф маскирующих компонентов на основании 
 санитизированной форматной строки.
 */
@interface FormatParser : NSObject

/**
 Метод, генерирующий граф маскирующих компонентов на основании форматной строки.
 
 @param format - форматная строка.
 
 @return Возвращает массив, содержащий граф маскирующих компонентов, основанный
 на форматной строке. 
 
 Первый элемент массива является компонентом, представляющим "вход" в граф.
 */
- (NSArray *)componentsFromFormatString:(NSString *)format;

@end
