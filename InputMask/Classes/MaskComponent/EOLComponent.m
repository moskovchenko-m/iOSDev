//
//  EOLComponent.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 26/02/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "EOLComponent.h"
#import "Transition.h"
#import "TransitionGraph.h"
#import "NSString+Character.h"

@implementation EOLComponent

- (instancetype)initWithTransitions:(TransitionGraph *)transitions variable:(BOOL)variable
{
    Transition *transition = [Transition transitionWithTarget:self
                                                       prefix:@""
                                                    valueable:NO];
    TransitionGraph *graph = [TransitionGraph graph];
    graph[[NSString anyCharacter]] = transition;

    return (self = [super initWithTransitions:graph variable:NO]);
}

- (BOOL)canPassCharacter:(NSString *)character
{
    return YES;
}

- (BOOL)characterIsValueable:(NSString *)character
{
    return NO;
}

- (MaskComponent *)passCharacter:(NSString *)character
{
    return self;
}

- (NSString *)prefixPassingCharacter:(NSString *)character
{
    return @"";
}

@end
