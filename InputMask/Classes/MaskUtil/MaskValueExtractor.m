//
//  MaskValueExtractor.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 03/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "MaskValueExtractor.h"
#import "MaskComponent.h"
#import "NSStringIterator.h"
#import "EOLComponent.h"

@implementation MaskValueExtractor

- (NSString *)extractValue:(NSString *)text
{
    MaskComponent *component = self.firstComponent;
    NSStringIterator *stringIterator = [NSStringIterator iteratorWithString:text];
    NSString *character = [stringIterator next];

    NSMutableString *result = [[NSMutableString alloc] init];

    while (component && character && [component canPassCharacter:character]) {
        if ([component isKindOfClass:[EOLComponent class]]) break;

        BOOL ownCharacter = [component isOwnCharacter:character];
        if ([component characterIsValueable:character] && ownCharacter) {
            [result appendString:character];
            component = [component passCharacter:character];
            character = [stringIterator next];
            continue;
        }

        if (ownCharacter) {
            component = [component passCharacter:character];
            character = [stringIterator next];
            continue;
        }
        
        component = [component passCharacter:character];
    }

    return result;
}

@end
