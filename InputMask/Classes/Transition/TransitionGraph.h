//
//  TransitionGraph.h
//  MaskedInput
//
//  Created by Egor Taflanidi on 26/02/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Граф, состоящий из переходов - объектов класса Transition - ключами для которых
 являются символы (одиночные) - объекты класса NSString.
 
 TransitionGraph является изменяемой коллекцией, наследником класса 
 NSMutableDictionary. 
 
 Соответственно, доступ к переходам в графе возможен посредством 
 синтаксиса graph[symbol]
 
 Для записи перехода в граф используется тот же синтаксис:
 graph[symbol] = transition;
 
 В случае, если в граф записан переход, ключом к которому является константа
 [NSString anyCharacter], граф будет возвращать этот переход в случае, если ни
 один другой не подошёл.
 
 !!! ВНИМАНИЕ !!!
 
 Настоятельно не рекомендуется для инстанциирования объектов данного класса
 использовать наследные конструкторы, вида +dictionaryWith...
 
 Вместо этого следует использовать назначенный конструктор +graph.
 */
@interface TransitionGraph : NSMutableDictionary

/**
 Назначенный конструктор.
 
 @return Возвращает инициированный объект класса TransitionGraph.
 */
+ (instancetype)graph;

@end
