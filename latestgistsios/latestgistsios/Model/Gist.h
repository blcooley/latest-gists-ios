//
//  Gist.h
//  latestgistsios
//
//  Created by Brian Cooley on 12/11/13.
//  Copyright (c) 2013 Cooley Mobile Development LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gist : NSObject

@property (nonatomic, readonly, strong) NSArray *gistFiles;
@property (nonatomic, readonly, strong) NSString *url;
@property (nonatomic, readonly, strong) NSString *id;
@property (nonatomic, readonly, strong) NSString *userLogin;
@property (nonatomic, readonly, strong) NSString *description;

@end
