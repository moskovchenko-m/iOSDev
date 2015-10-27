//
//  MultiCharacterValueableComponent.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskComponent.h"

/**
 Маскирующий компонент для символов в квадратных скобках.
 
 Компонент может включать в себя массив "собственных" символов 
 (-isOwnCharacter = YES).
 
 Если символ не является опциональным, компонент не будет обрабатывать символы,
 не подходящие по формату.
 
 Для опциональных символов ("9", "а" и "-" в форматной строке) предусмотрен
 переход к побочному маскирующему компоненту (collateralTarget), который может 
 быть инициирован посредством перехода "по умолчанию" - см. 
 [NSString anyCharacter].
 
 Например, для форматной строки
 [009]-{42}
 в случае ввода пользователем
 12
 маска способна обработать последующий символ "-", приводя значение строки ввода
 к виду
 12-
 При этом сразу идёт переход к маскирующему компоненту, отвечающему за символ 
 "4" в фигурных скобках.
 
 @see NSString (Character)
 */
@interface MultiCharacterValueableComponent : MaskComponent

/**
 Конструктор. 
 Позволяет создать маскирующий компонент для обязательных и опциональных 
 символов в квадратных скобках.
 
 @param ownCharacters - массив "собственных" символов компонента.
 @param variable - метка, является ли символ строки формата опциональным.
 @param target - маскирующий компонент, к которому следует переходить после 
 обработки символа.
 @param collateralTarget - побочный маскирующий компонент, к которому следует
 переходить в случае опционального форматного символа.
 
 @return Возвращает инициированный маскирующий компонент.
 */
- (instancetype)initWithCharacters:(NSArray *)ownCharacters
                    variableSymbol:(BOOL)variable
                            target:(MaskComponent *)target
                  collateralTarget:(MaskComponent *)collateralTarget;

@end
