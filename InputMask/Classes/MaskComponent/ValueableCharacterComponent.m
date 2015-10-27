//
//  ValueableCharacterComponent.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "ValueableCharacterComponent.h"

#import "Transition.h"
#import "TransitionGraph.h"

#import "NSString+Character.h"

@implementation ValueableCharacterComponent

- (instancetype)initWithCharacter:(NSString *)character
                           target:(MaskComponent *)target
{
    TransitionGraph *graph = [TransitionGraph graph];
    graph[character] = [Transition transitionWithTarget:target
                                                 prefix:@""
                                              valueable:YES];

    graph[[NSString anyCharacter]] = [Transition transitionWithTarget:target
                                                               prefix:character
                                                            valueable:YES];

    return [self initWithTransitions:graph variable:NO];
}

@end
