//
//  NSString+Character.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 02/03/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "NSString+Character.h"

#import "NSStringIterator.h"

@implementation NSString (Character)

+ (NSString *)anyCharacter
{
    return @"\n";
}

+ (NSArray *)numbers
{
    return [self charactersArrayFromString:@"0123456789"];
}

+ (NSArray *)letters
{
    NSString *lettersString = @"абвгдеёжзиклмнопрстуфхцчшщъыьэюяabcdefghijklmnopqrstuvwxyz";
    lettersString = [[lettersString uppercaseString] stringByAppendingString:lettersString];
    return [self charactersArrayFromString:lettersString];
}

+ (NSArray *)charactersArrayFromString:(NSString *)string
{
    NSStringIterator *iterator = [NSStringIterator iteratorWithString:string];
    NSMutableArray *characters = [[NSMutableArray alloc] init];
    NSString *character = nil;
    while ((character = [iterator next])) [characters addObject:character];
    return characters;
}

+ (NSArray *)numbersAndLetters
{
    return [[self numbers] arrayByAddingObjectsFromArray:[self letters]];
}

+ (NSString *)stringWithCharacter:(unichar)character
{
    return [NSString stringWithCharacters:&character length:1];
}

@end
