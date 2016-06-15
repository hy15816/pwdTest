//
//  NSDictionary+LSAdd.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/7.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "NSDictionary+LSAdd.h"

@implementation NSDictionary (LSAdd)

- (NSString*) stringForKey:(id)key {
    id s = [self objectForKey:key];
    if (s == [NSNull null] || ![s isKindOfClass:[NSString class]]) {
        return @"";
    }
    return s;
}

- (NSNumber*) numberForKey:(id)key {
    id s = [self objectForKey:key];
    if (s == [NSNull null] || ![s isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    return s;
}

- (NSMutableDictionary*) dictionaryForKey:(id)key {
    id s = [self objectForKey:key];
    if (s == [NSNull null] || ![s isKindOfClass:[NSMutableDictionary class]]) {
        return nil;
    }
    return s;
}

- (NSMutableArray*) arrayForKey:(id)key {
    id s = [self objectForKey:key];
    if (s == [NSNull null] || ![s isKindOfClass:[NSMutableArray class]]) {
        return nil;
    }
    return s;
}

@end
