//
//  MaskComponent.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 26/02/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskComponent.h"
#import "Transition.h"
#import "TransitionGraph.h"
#import "NSString+Character.h"

@interface MaskComponent ()

@property (nonatomic, strong) TransitionGraph *transitions;
@property (nonatomic, assign) BOOL variable;

@end

@implementation MaskComponent

#pragma mark - Конструкторы

- (instancetype)initWithTransitions:(TransitionGraph *)transitions variable:(BOOL)variable
{
    if (self = [super init]) {
        self.transitions = transitions;
        self.variable = variable;
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.transitions = [TransitionGraph graph];
        self.variable = NO;
    }
    return self;
}

#pragma mark - Публичные методы

- (BOOL)canPassCharacter:(NSString *)character
{
    return self.transitions[character] != nil;
}

- (BOOL)characterIsValueable:(NSString *)character
{
    Transition *transition = self.transitions[character];
    return transition ? transition.valueable : NO;
}

- (BOOL)isOwnCharacter:(NSString *)character
{
    Transition *defaultTransition = self.transitions[[NSString anyCharacter]];
    Transition *transition = self.transitions[character];
    
    if (!transition) return NO;
    return transition != defaultTransition;
}

- (MaskComponent *)passCharacter:(NSString *)character
{
    Transition *transition = self.transitions[character];
    return transition ? transition.target : nil;
}

- (NSString *)prefixPassingCharacter:(NSString *)character
{
    Transition *transition = self.transitions[character];
    return transition ? transition.prefix : nil;
}

#pragma mark - NSObject

- (NSString *)description
{
    return [self debugDescription];
}

- (NSString *)debugDescription
{
    NSMutableString *description = [[NSMutableString alloc] init];
    [description appendString:@"Own characters: "];

    for (NSString *character in self.transitions.allKeys) {
        if ([character isEqualToString:[NSString anyCharacter]]) continue;
        [description appendString:character];
    }

    [description appendString:@" Has collateral transitions: "];
    for (NSString *character in self.transitions.allKeys) {
        if ([character isEqualToString:[NSString anyCharacter]]) {
            [description appendString:@"YES"];
            return description;
        }
    }

    [description appendString:@"NO"];
    return description;
}

@end
