//
//  MaskTestCase.h
//  InputMask
//
//  Created by Egor Taflanidi on 07/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InputMask.h"

/**
 Формат теста для класса Mask.
 */
@interface MaskTestCase : XCTestCase

/**
 Тестируемый объект.
 */
@property (nonatomic, strong, readonly) Mask *mask;

/**
 Абстрактный метод, задающий формат маски.
 Например, +7 ([000]) [000] [00] [00]
 
 @return Возвращает формат, используемый для конструирования маски.
 @exception Реализация по умолчанию бросает исключение.
 */
- (NSString *)maskFormat;

@end
