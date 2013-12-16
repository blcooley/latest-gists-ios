//
//  DetailViewController.h
//  latestgistsios
//
//  Created by Brian Cooley on 12/11/13.
//  Copyright (c) 2013 Cooley Mobile Development LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GistFile;

@interface DetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (strong, nonatomic) GistFile *detailItem;

@end
