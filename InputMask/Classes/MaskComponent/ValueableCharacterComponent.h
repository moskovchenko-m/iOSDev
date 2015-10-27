//
//  ValueableCharacterComponent.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskComponent.h"

/**
 Маскирующий компонент для символов в фигурных скобках.
 
 Символы в фигурных скобках являются обязательными для пересылки на сервер.
 В то же время, блок символов в фигурных скобках является постоянным, и не может 
 быть изменён пользователем.
 
 Данный компонент способен пропустить любой символ с той разницей, что для 
 "собственных" символов (-isOwnCharacter == YES) не будет возвращаться префикс.
 */
@interface ValueableCharacterComponent : MaskComponent

/**
 Конструктор.
 Позволяет создать маскирующий компонент для символа в фигурных скобках.
 
 @param character - символ в фигурных скобках. Будет служить "собственным"
 символом компонента. Не nil.
 @param target - маскирующий компонент, к которому следует переходить после 
 обработки символа.
 
 @return Возвращает инициированный объект класса ValueableCharacterComponent.
 */
- (instancetype)initWithCharacter:(NSString *)character 
                           target:(MaskComponent *)target;

@end
