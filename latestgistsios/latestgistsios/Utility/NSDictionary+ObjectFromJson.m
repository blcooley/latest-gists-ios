//
//  NSDictionary+ObjectFromJson.m
//  latestgistsios
//
//  Created by Brian Cooley on 12/12/13.
//  Copyright (c) 2013 Cooley Mobile Development LLC. All rights reserved.
//

#import "NSDictionary+ObjectFromJson.h"

@implementation NSDictionary (ObjectFromJson)

- (id)objectForKeyNullSafe:(NSString *)key {
    id object = [self objectForKey:key];
    if (object == [NSNull null] || (__bridge CFNullRef)object == kCFNull) {
        object = nil;
    }
    return object;
}
@end
