//
//  MaskCleaner.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MaskUtil.h"

@class MaskComponent;

/**
 Утилита, производящая чистку текста после его форматирования.
 
 Чистка призвана удалить из текста лишние префиксы, оставшиеся в результате его
 форматирования.
 */
@interface MaskCleaner : MaskUtil

/**
 Вычистить текст, подвергшийся форматированию, от остаточных артефактов 
 (префиксов).
 
 @param text - текст, подвергшийся форматированию. Не nil.
 
 @return Возвращает текст, очищенный от артефактов форматирования.
 */
- (NSString *)cleanText:(NSString *)text;

@end
