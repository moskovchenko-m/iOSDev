//
//  MaskCleaner.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskCleaner.h"
#import "MaskComponent.h"
#import "NSStringIterator.h"
#import "EOLComponent.h"

@implementation MaskCleaner

- (NSString *)cleanText:(NSString *)text
{
    MaskComponent *component = self.firstComponent;
    NSStringIterator *stringIterator = [NSStringIterator iteratorWithString:text];
    NSString *character = [stringIterator next];

    NSMutableString *result = [[NSMutableString alloc] init];

    while (component && character) {
        if ([component isKindOfClass:[EOLComponent class]]) break;

        if (![component canPassCharacter:character]) {
            character = [stringIterator next];
            continue;
        }

        if ([[component prefixPassingCharacter:character] length] > 0) {
            [result appendString:[component prefixPassingCharacter:character]];
            component = [component passCharacter:character];
            continue;
        }

        if (!component.variable) {
            [result appendString:character];
            component = [component passCharacter:character];
            character = [stringIterator next];
            continue;
        }

        BOOL ownCharacter = [component isOwnCharacter:character];
        if (ownCharacter) {
            [result appendString:character];
            character = [stringIterator next];
            component = [component passCharacter:character];
            continue;
        }
        
        MaskComponent *componentAfterVariadicBlock = [component passCharacter:character];
        if ([componentAfterVariadicBlock isOwnCharacter:character]) {
            [result appendString:character];
            component = [componentAfterVariadicBlock passCharacter:character];
            character = [stringIterator next];
        } else {
            character = [stringIterator next];
        }
    }

    return result;
}

@end
