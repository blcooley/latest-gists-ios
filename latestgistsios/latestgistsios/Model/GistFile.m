//
//  GistFile.m
//  latestgistsios
//
//  Created by Brian Cooley on 12/11/13.
//  Copyright (c) 2013 Cooley Mobile Development LLC. All rights reserved.
//

#import "GistFile.h"
#import "NSDictionary+ObjectFromJson.h"

@interface GistFile () {
    NSDictionary *_jsonObject;
}

@end
@implementation GistFile

#define KEY_FILENAME @"filename"
#define KEY_LANGUAGE @"language"
#define KEY_RAW_URL @"raw_url"

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _jsonObject = dictionary;
    }
    return self;
}

- (NSString *)filename {
    return [_jsonObject objectForKeyNullSafe:KEY_FILENAME];
}

- (NSString *)language {
    return [_jsonObject objectForKeyNullSafe:KEY_LANGUAGE];
}

- (NSString *)rawUrl {
    return [_jsonObject objectForKeyNullSafe:KEY_RAW_URL];
}

@end
