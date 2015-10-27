//
//  MultiCharacterValueableComponent.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MultiCharacterValueableComponent.h"
#import "TransitionGraph.h"
#import "Transition.h"
#import "NSString+Character.h"

@implementation MultiCharacterValueableComponent

- (instancetype)initWithCharacters:(NSArray *)ownCharacters
                    variableSymbol:(BOOL)variable
                            target:(MaskComponent *)target
                  collateralTarget:(MaskComponent *)collateralTarget
{
    TransitionGraph *graph = [TransitionGraph graph];

    for (NSString *symbol in ownCharacters) {
        graph[symbol] = [Transition transitionWithTarget:target
                                                  prefix:@""
                                               valueable:YES];
    }

    if (collateralTarget)
        graph[[NSString anyCharacter]] = [Transition transitionWithTarget:collateralTarget
                                                                   prefix:@""
                                                                valueable:YES];

    return [self initWithTransitions:graph variable:variable];
}

@end
