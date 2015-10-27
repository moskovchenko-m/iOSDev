//
//  TransitionGraph.m
//  MaskedInput
//
//  Created by Egor Taflanidi on 26/02/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "TransitionGraph.h"

#import "NSString+Character.h"

@interface TransitionGraph ()
@property (nonatomic, strong) NSMutableDictionary *proxy;
@end

@implementation TransitionGraph

#pragma mark - Конструкторы

+ (instancetype)graph
{
    TransitionGraph *graph = [[TransitionGraph alloc] init];
    return graph;
}

#pragma mark - NSMutableDictionary proxy

- (id)init
{
    if (self = [super init]) {
        self.proxy = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSUInteger)count
{
    return [self.proxy count];
}

- (id)objectForKey:(id)aKey
{
    if (!aKey) return nil;
    if (![aKey isKindOfClass:[NSString class]]) return nil;

    if (self.proxy[aKey] == nil && [self.allKeys containsObject:[NSString anyCharacter]]) {
        return self.proxy[[NSString anyCharacter]];
    }

    return self.proxy[aKey];
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!aKey) return;
    if (![((id<NSObject>)aKey) isKindOfClass:[NSString class]]) return;

    if (anObject) {
        self.proxy[aKey] = anObject;
    } else {
        [self.proxy removeObjectForKey:aKey];
    }
}

- (NSEnumerator *)keyEnumerator
{
    return [self.proxy keyEnumerator];
}

- (void)removeObjectForKey:(id)aKey
{
    if (!aKey) return;
    if (![aKey isKindOfClass:[NSString class]]) return;

    [self.proxy removeObjectForKey:aKey];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.proxy;
}

- (void)setObject:(id)object
forKeyedSubscript:(id<NSCopying>)key
{
    if (!key) return;
    if (![((id<NSObject>)key) isKindOfClass:[NSString class]]) return;

    self.proxy[key] = object;
}

- (id)objectForKeyedSubscript:(id)key
{
    if (!key) return nil;
    if (![key isKindOfClass:[NSString class]]) return nil;

    if (self.proxy[key] == nil && [self.allKeys containsObject:[NSString anyCharacter]]) {
        return self.proxy[[NSString anyCharacter]];
    }
    
    return self.proxy[key];
}

@end
