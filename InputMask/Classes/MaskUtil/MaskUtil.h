//
//  MaskUtil.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MaskComponent;

/**
 Утилита, используемая классом Mask для обработки текста согласно графу 
 маскирующих компонентов.
 
 Каждая подобная утилита получает первый маскирующий компонент, отталкиваясь от
 него при итерировании по символам строки.
 
 По умолчанию предполагается, что обрабатываемая строка отдаётся утилите 
 полностью, начиная с первого символа - для соответствия первому маскирующему
 компоненту. 
 
 @exception Конструктор -init бросает исключение.
 */
@interface MaskUtil : NSObject

/**
 Первый маскирующий компонент в графе маски.
 */
@property (nonatomic, strong, readonly) MaskComponent *firstComponent;

/**
 Конструктор.
 Позволяет создавать утилиту для обработки текста согласно последовательности
 маскирующих компонентов.
 
 @param firstComponent - первый маскирующий компонент, с которого начинается 
 граф остальных компонентов. Не nil.
 
 @return Возвращает инициированную утилиту.
 */
- (instancetype)initWithFirstComponent:(MaskComponent *)firstComponent;

/**
 Конструктор.
 Позволяет создавать утилиту для обработки текста согласно последовательности
 маскирующих компонентов.
 
 @param firstComponent - первый маскирующий компонент, с которого начинается 
 граф остальных компонентов. Не nil.
 
 @return Возвращает инициированную утилиту.
 */
+ (instancetype)utilWithFirstComponent:(MaskComponent *)firstComponent;

@end
