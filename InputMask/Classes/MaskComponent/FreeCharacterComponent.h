//
//  FreeCharacterComponent.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskComponent.h"

/**
 Маскирующий компонент для символов вне квадратных и фигурных скобок.
 
 Данный компонент способен пропустить любой символ с той разницей, что для 
 "собственных" символов (-isOwnCharacter == YES) не будет возвращаться префикс.
 
 Любой символ, пропускаемый компонентом, не является значимым для сервера.
 */
@interface FreeCharacterComponent : MaskComponent

/**
 Конструктор.
 Позволяет создать маскирующий компонент для "свободного" символа - символа вне
 квадратных и фигурных скобок.
 
 @param character - символ. Будет служить "собственным" символом компонента.
 Не nil.
 @param target - следующий маскирующий компонент, к которому следует переходить
 при обработке символа.
 
 @return Возвращает инициированный объект класса FreeCharacterComponent.
 */
- (instancetype)initWithCharacter:(NSString *)character 
                           target:(MaskComponent *)target;

@end
