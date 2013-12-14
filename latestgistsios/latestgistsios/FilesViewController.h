//
//  FilesViewController.h
//  latestgistsios
//
//  Created by Brian Cooley on 12/13/13.
//  Copyright (c) 2013 Cooley Mobile Development LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GistFile;

@interface FilesViewController : UITableViewController

@property (strong, nonatomic) NSArray *gistFiles;

@end
