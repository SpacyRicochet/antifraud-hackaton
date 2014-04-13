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

@interface AFHTableViewController () <NWComposedTableViewDataSourceDelegate>

@property (nonatomic, strong) NSMutableArray *dataObjects;
@property (nonatomic, strong) NWComposedTableViewDataSource *composedDataSource;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSUInteger selectedRow;
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

- (BOOL)prefersStatusBarHidden
{
    if (self.dataObjects)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - Setup Datasource

- (void)setupDataSource
{
    self.composedDataSource = [[NWComposedTableViewDataSource alloc] initWithTableView:self.tableView];
    self.composedDataSource.delegate = self;
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

- (void)tableViewDataSource:(NWComposedTableViewDataSource *)dataSource configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withObject:(AFHActivity *)activity
{
    cell.textLabel.text = activity.event;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    int i = indexPath.row % 4;
    switch (i) {
        case 0:{
            [cell.imageView setImage:[UIImage imageNamed:@"Creditcard"]];
        }   break;
        case 1:{
            [cell.imageView setImage:[UIImage imageNamed:@"doctor2"]];
        }   break;
        case 2:{
            [cell.imageView setImage:[UIImage imageNamed:@"Home"]];
        }   break;
        case 3:{
            [cell.imageView setImage:[UIImage imageNamed:@"Law"]];
        }   break;
        default:
            break;
    }
}

//#pragma mark - Table view data source
//
//- (void)setupData
//{
//    NSArray *descriptions = @[@"Ingeschreven op adres",
//                              @"Subsidie aangevraagd",
//                              @"Rekening opgeheven",
//                              @"Bedrijf opgericht",
//                              @"Krediet aangevraagd",
//                              @"ID bewijs opgegeven als gestolen",
//                              @"ID bewijs aangevraagd",
//                              @"Hypotheek verstrekt",
//                              @"Aanmerking op strafblad",
//                              @"Ingelogd op de pagina van DigiD"];
//    NSArray *accessors = @[@"Gemeente Delft",
//                           @"Stimuleringsfonds",
//                           @"Bank",
//                           @"Kamer van Koophandel",
//                           @"Bank",
//                           @"Gemeente Delft",
//                           @"Gemeente Delft",
//                           @"Bank",
//                           @"Rechtbank",
//                           @"Overheid"];
//    
//    self.dataObjects = @[].mutableCopy;
//    for (int i = 0; i < 10; i++)
//    {
//        AFHDataObject *dataObject = [AFHDataObject new];
//        dataObject.description = descriptions[i];
//        dataObject.accessor = accessors[i];
//        dataObject.timeStamp = [NSDate new];
//        [self.dataObjects addObject:dataObject];
//    }
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.dataObjects.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell" forIndexPath:indexPath];
//    AFHDataObject *dataObject = [self.dataObjects objectAtIndex:indexPath.row];
//    cell.textLabel.text = dataObject.description;
//    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
//    cell.detailTextLabel.text = [dateFormatter stringFromDate:dataObject.timeStamp];
//    
//    int i = indexPath.row % 4;
//    
//    switch (i) {
//        case 0:{
//            [cell.imageView setImage:[UIImage imageNamed:@"Creditcard"]];
//        }   break;
//        case 1:{
//            [cell.imageView setImage:[UIImage imageNamed:@"doctor2"]];
//        }   break;
//        case 2:{
//            [cell.imageView setImage:[UIImage imageNamed:@"Home"]];
//        }   break;
//        case 3:{
//            [cell.imageView setImage:[UIImage imageNamed:@"Law"]];
//        }   break;
//    }
//    
//    return cell;
//}

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
    detailVC.dataObject = [self.dataObjects objectAtIndex:self.selectedRow];
    UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedRow inSection:0]];
    detailVC.image = cell.imageView.image;
}

@end
