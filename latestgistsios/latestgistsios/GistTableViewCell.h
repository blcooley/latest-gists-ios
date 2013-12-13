//
//  GistTableViewCell.h
//  latestgistsios
//
//  Created by Brian Cooley on 12/13/13.
//  Copyright (c) 2013 Cooley Mobile Development LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GistTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *userLoginLabel;
@property (nonatomic, strong) UILabel *gistIdLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *languagesLabel;

@end
