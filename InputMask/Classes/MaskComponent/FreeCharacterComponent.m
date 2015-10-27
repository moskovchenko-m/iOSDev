//
//  FreeCharacterComponent.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "FreeCharacterComponent.h"

#import "TransitionGraph.h"
#import "Transition.h"

#import "NSString+Character.h"

@implementation FreeCharacterComponent

- (instancetype)initWithCharacter:(NSString *)character target:(MaskComponent *)target
{
    TransitionGraph *graph = [TransitionGraph graph];
    graph[character] = [Transition transitionWithTarget:target
                                                 prefix:@""
                                              valueable:NO];

    graph[[NSString anyCharacter]] = [Transition transitionWithTarget:target
                                                               prefix:character
                                                            valueable:NO];

    return [self initWithTransitions:graph variable:NO];
}

@end
