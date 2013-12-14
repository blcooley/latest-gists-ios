//
//  MasterViewController.m
//  latestgistsios
//
//  Created by Brian Cooley on 12/11/13.
//  Copyright (c) 2013 Cooley Mobile Development LLC. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "GistTableViewCell.h"
#import "Gist.h"
#import "FilesViewController.h"

#define SEGUE_FILES @"GistsToFiles"
#define SEGUE_DETAIL @"GistsToDetail"

@interface MasterViewController () {
    NSArray *_gists;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Pull to Refresh"];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self loadGists];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadGists {
    NSURL *URL = [NSURL URLWithString:@"https://api.github.com/gists/public"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      [self parseJsonData:data];
                                  }];
    
    [task resume];
}

- (void) parseJsonData:(NSData*)data
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        NSArray *jsonGists = [NSJSONSerialization JSONObjectWithData:data
                                                 options:kNilOptions
                                                   error:&error];
        NSMutableArray *gists = [NSMutableArray arrayWithCapacity:[jsonGists count]];
        for (NSDictionary *gist in jsonGists) {
            [gists addObject:[[Gist alloc] initWithDictionary:gist]];
        }
        _gists = [NSArray arrayWithArray:gists];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        });
    });
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _gists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GistCell" forIndexPath:indexPath];

    Gist *gist = _gists[indexPath.row];
    cell.userLoginLabel.text = gist.userLogin;
    cell.gistIdLabel.text = gist.id;
    cell.descriptionLabel.text = gist.description;
    cell.languagesLabel.text = gist.languages;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Gist *gist = [_gists objectAtIndex:indexPath.row];
    if ([gist.gistFiles count] == 1) {
        [self performSegueWithIdentifier:SEGUE_DETAIL sender:nil];
    } else {
        [self performSegueWithIdentifier:SEGUE_FILES sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:SEGUE_DETAIL]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        GistFile *gistFile = [[_gists[indexPath.row] gistFiles] objectAtIndex:0];
        [[segue destinationViewController] setDetailItem:gistFile];
    } else if ([[segue identifier] isEqualToString:SEGUE_FILES]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *gistFiles =[_gists[indexPath.row] gistFiles];
        ((FilesViewController*)[segue destinationViewController]).gistFiles = gistFiles;
    }
}

- (void)refresh
{
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing the TableView"];
    NSDateFormatter *formattedDate = [[NSDateFormatter alloc] init];
    [formattedDate setDateFormat:@"MMM d, h:mm a"];
    NSString *lastupdated = [NSString stringWithFormat:@"Last Updated on %@",[formattedDate stringFromDate:[NSDate date]]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:lastupdated];
    [self loadGists];
}

@end
