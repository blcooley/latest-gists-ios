//
//  Gist.m
//  latestgistsios
//
//  Created by Brian Cooley on 12/11/13.
//  Copyright (c) 2013 Cooley Mobile Development LLC. All rights reserved.
//
//  Sample JSON for a gist:
/* {
    "url": "https://api.github.com/gists/7923952",
    "forks_url": "https://api.github.com/gists/7923952/forks",
    "commits_url": "https://api.github.com/gists/7923952/commits",
    "id": "7923952",
    "git_pull_url": "https://gist.github.com/7923952.git",
    "git_push_url": "https://gist.github.com/7923952.git",
    "html_url": "https://gist.github.com/7923952",
    "files": {
        "error": {
            "filename": "error",
            "type": "text/plain",
            "language": null,
            "raw_url": "https://gist.github.com/tfitts/7923952/raw/3c4f01ce8631dbbd808f1b258d78be150c3256f2/error",
            "size": 429
        },
        "messages_controller.rb": {
            "filename": "messages_controller.rb",
            "type": "application/ruby",
            "language": "Ruby",
            "raw_url": "https://gist.github.com/tfitts/7923952/raw/ba12b15badcda33a685db9432824c4b99553b038/messages_controller.rb",
            "size": 1266
        }
    },
    "public": true,
    "created_at": "2013-12-12T06:23:04Z",
    "updated_at": "2013-12-12T06:23:05Z",
    "description": "",
    "comments": 0,
    "user": {
        "login": "tfitts",
        "id": 1738443,
        "avatar_url": "https://gravatar.com/avatar/f52b51d0cd5d6137ebdd8004fefd92e1?d=https%3A%2F%2Fidenticons.github.com%2F8d95b949dd628a92ca8fff1ee8337ea8.png&r=x",
        "gravatar_id": "f52b51d0cd5d6137ebdd8004fefd92e1",
        "url": "https://api.github.com/users/tfitts",
        "html_url": "https://github.com/tfitts",
        "followers_url": "https://api.github.com/users/tfitts/followers",
        "following_url": "https://api.github.com/users/tfitts/following{/other_user}",
        "gists_url": "https://api.github.com/users/tfitts/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/tfitts/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/tfitts/subscriptions",
        "organizations_url": "https://api.github.com/users/tfitts/orgs",
        "repos_url": "https://api.github.com/users/tfitts/repos",
        "events_url": "https://api.github.com/users/tfitts/events{/privacy}",
        "received_events_url": "https://api.github.com/users/tfitts/received_events",
        "type": "User",
        "site_admin": false
    },
    "comments_url": "https://api.github.com/gists/7923952/comments"
}
*/

#import "Gist.h"
#import "GistFile.h"
#import "NSDictionary+ObjectFromJson.h"

#define KEY_DESCRIPTION @"description"
#define KEY_USER @"user"
#define KEY_LOGIN @"login"
#define KEY_ID @"id"
#define KEY_FILES @"files"

@interface Gist () {
    NSDictionary *_jsonData;
}
@end

@implementation Gist

- (id) initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _jsonData = dictionary;
        if (_jsonData) {
            NSDictionary *jsonFiles = [_jsonData objectForKeyNullSafe:KEY_FILES];
            NSMutableArray *files = [NSMutableArray arrayWithCapacity:[[jsonFiles allKeys] count]];
            for (NSString *key in [jsonFiles allKeys]) {
                [files addObject:[[GistFile alloc] initWithDictionary:[jsonFiles objectForKey:key]]];
            }
            _gistFiles = [NSArray arrayWithArray:files];
        }
    }
    return self;
}

- (NSString *)description {
    return [_jsonData objectForKeyNullSafe:KEY_DESCRIPTION];
}

- (NSString *) id {
    return [_jsonData objectForKeyNullSafe:KEY_ID];
}

- (NSString*)languages
{
    NSMutableString *langs = [NSMutableString stringWithString:@""];
    if ([self.gistFiles count] > 0) {
        for (GistFile *file in self.gistFiles) {
            [langs appendString:[NSString stringWithFormat:@"%@, ", file.language]];
        }
    }
    
    // return immutable copy with all but the final comma and space
    if ([langs length] > 2) {
        langs = [[langs substringToIndex:[langs length]-2] mutableCopy];
    }
    return [NSString stringWithString:langs];
}

- (NSString *)userLogin {
    return [[_jsonData objectForKeyNullSafe:@"user"] objectForKeyNullSafe:@"login"];
}
@end
