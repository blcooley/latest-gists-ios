//
//  GistFile.h
//  latestgistsios
//
//  Created by Brian Cooley on 12/11/13.
//  Copyright (c) 2013 Cooley Mobile Development LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GistFile : NSObject

@property (nonatomic, readonly, strong) NSString *filename;
@property (nonatomic, readonly, strong) NSString *language;
@property (nonatomic, readonly, strong) NSString *rawUrl;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
