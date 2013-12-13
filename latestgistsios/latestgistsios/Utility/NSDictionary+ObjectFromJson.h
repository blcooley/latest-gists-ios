//
//  NSDictionary+ObjectFromJson.h
//  latestgistsios
//
//  Created by Brian Cooley on 12/12/13.
//  Copyright (c) 2013 Cooley Mobile Development LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ObjectFromJson)

- (id)objectForKeyNullSafe:(NSString *)key;

@end
