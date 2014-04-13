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
#import "NWComposedTableViewDataSource.h"
#import "AFHActivity.h"
#import "AFHCoreDataChief.h"
#import "AFHActivityTableViewCell.h"
#import "AFHAditionalDataHelper.h"

@interface AFHTableViewController () <NWComposedTableViewDataSourceDelegate>

@property (nonatomic, strong) NWComposedTableViewDataSource *composedDataSource;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSUInteger selectedRow;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation AFHTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60;
    self.navigationItem.hidesBackButton = YES;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[AFHActivity entityName]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[AFHCoreDataChief shared].managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController = fetchedResultsController;
    
    [self setupDataSource];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}

#pragma mark - Setup Datasource

- (void)setupDataSource
{
    self.composedDataSource = [[NWComposedTableViewDataSource alloc] initWithTableView:self.tableView];
    self.composedDataSource.delegate = self;
    self.composedDataSource.tableViewRowAnimationInsert = UITableViewRowAnimationLeft;
}

#pragma mark - Composed Table View Data Source Delegate

- (NSUInteger)sectionCountForTableViewDataSource:(NWComposedTableViewDataSource *)dataSource
{
    return 1;
}

- (id)sourceForTableViewDataSource:(NWComposedTableViewDataSource *)dataSource forSection:(NSUInteger)section
{
    return self.fetchedResultsController;
}

- (NSDateFormatter *)dateFormatter
{
    if (_dateFormatter) {
        return _dateFormatter;
    }
    
    _dateFormatter = [NSDateFormatter new];
    [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return _dateFormatter;
}

- (void)tableViewDataSource:(NWComposedTableViewDataSource *)dataSource configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withObject:(AFHActivity *)activity
{
    cell.textLabel.text = activity.event;
    
    NSString *dateString = [self.dateFormatter stringFromDate:activity.date];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", activity.accessor, dateString];
    NSDictionary *dict = [AFHAditionalDataHelper dictForKey:activity.event];
    [cell.imageView setImage:[dict image]];
}

- (Class)tableViewDataSource:(NWComposedTableViewDataSource *)dataSource cellClassForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AFHActivityTableViewCell class];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"detailViewSegue" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AFHDetailViewController *detailVC = [segue destinationViewController];
    detailVC.dataObject = [self.fetchedResultsController.fetchedObjects objectAtIndex:self.selectedRow];
    UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedRow inSection:0]];
    detailVC.image = cell.imageView.image;
}

@end
