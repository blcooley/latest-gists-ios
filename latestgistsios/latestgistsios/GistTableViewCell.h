//
//  GistTableViewCell.h
//  latestgistsios
//
//  Created by Brian Cooley on 12/13/13.
//  Copyright (c) 2013 Cooley Mobile Development LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GistTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *userLoginLabel;
@property (nonatomic, weak) IBOutlet UILabel *gistIdLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *languagesLabel;

@end
