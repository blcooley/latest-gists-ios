//
//  FilesViewController.m
//  latestgistsios
//
//  Created by Brian Cooley on 12/13/13.
//  Copyright (c) 2013 Cooley Mobile Development LLC. All rights reserved.
//

#import "FilesViewController.h"
#import "GistFile.h"
#import "DetailViewController.h"

#define SEGUE_FILES_DETAIL @"FilesToDetail"

@interface FilesViewController ()

@end

@implementation FilesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.gistFiles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    GistFile *gistFile = [self.gistFiles objectAtIndex:indexPath.row];
    cell.textLabel.text = gistFile.filename;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:SEGUE_FILES_DETAIL]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        GistFile *gistFile = [self.gistFiles objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:gistFile];
    }
}

@end
