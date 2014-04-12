//
//  AFHTableViewController.m
//  AntiFraudeHackathon
//
//  Created by Jonas Treub on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHTableViewController.h"
#import "AFHDataObject.h"
#import "AFHDetailViewController.h"

@interface AFHTableViewController ()
{
    NSMutableArray *_dataObjects;
    
    NSUInteger _selectedRow;
}
@end

@implementation AFHTableViewController

- (BOOL)prefersStatusBarHidden
{
    if (_dataObjects)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}

- (void)setupData
{
    NSArray *descriptions = @[@"Ingeschreven op adres",
                              @"Subsidie aangevraagd",
                              @"Rekening opgeheven",
                              @"Bedrijf opgericht",
                              @"Krediet aangevraagd",
                              @"ID bewijs opgegeven als gestolen",
                              @"ID bewijs aangevraagd",
                              @"Hypotheek verstrekt",
                              @"Aanmerking op strafblad",
                              @"Ingelogd op de pagina van DigiD"];
    NSArray *accessors = @[@"Gemeente Delft",
                           @"Stimuleringsfonds",
                           @"Bank",
                           @"Kamer van Koophandel",
                           @"Bank",
                           @"Gemeente Delft",
                           @"Gemeente Delft",
                           @"Bank",
                           @"Rechtbank",
                           @"Overheid"];
    
    _dataObjects = @[].mutableCopy;
    for (int i = 0; i < 10; i++)
    {
        AFHDataObject *dataObject = [AFHDataObject new];
        dataObject.description = descriptions[i];
        dataObject.accessor = accessors[i];
        dataObject.timeStamp = [NSDate new];
        [_dataObjects addObject:dataObject];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupData];
    
    self.tableView.rowHeight = 54;
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    return _dataObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell" forIndexPath:indexPath];
    AFHDataObject *dataObject = [_dataObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = dataObject.description;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:dataObject.timeStamp];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"detailViewSegue" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AFHDetailViewController *detailVC = [segue destinationViewController];
    detailVC.dataObject = [_dataObjects objectAtIndex:_selectedRow];
}

@end
