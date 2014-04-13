//
//  NWComposedTableViewDataSource.m
//  NWTools
//
//  Created by Leonard van Driel
//  Copyright 2012 noodlewerk. All rights reserved.
//

#import "NWComposedTableViewDataSource.h"


@interface NWComposedTableViewDataSourceHelper : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, assign) NWComposedTableViewDataSource *dataSource;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) id source;
@property (nonatomic) id<NWComposedTableViewDataSourceDelegate> delegate;
@property (nonatomic) NSUInteger section;
@property (nonatomic) UITableViewRowAnimation tableViewRowAnimationInsert;
@property (nonatomic) UITableViewRowAnimation tableViewRowAnimationDelete;

@end


@implementation NWComposedTableViewDataSource {
    NSMutableDictionary *helperForSection;
    NSUInteger sectionCountCache;
}

@synthesize tableView, delegate;
@synthesize tableViewRowAnimationInsert, tableViewRowAnimationDelete;

#pragma mark - Object life cycle

- (id)initWithTableView:(UITableView *)_tableView
{
    self = [super init];
    if (self) {
        tableView = _tableView;
        tableView.dataSource = self;
        tableViewRowAnimationInsert = UITableViewRowAnimationFade;
        tableViewRowAnimationDelete = UITableViewRowAnimationFade;
        helperForSection = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc
{
    tableView.dataSource = nil;
    for (NWComposedTableViewDataSourceHelper *helper in helperForSection.allValues) {
        helper.dataSource = nil;
    }
}


#pragma mark - Accessors

- (NSUInteger)sectionCount
{
    if (!sectionCountCache) {
        sectionCountCache = [delegate sectionCountForTableViewDataSource:self];
    }
    return sectionCountCache;
}

- (NSUInteger)countForSection:(NSUInteger)section
{
    id source = [self sourceForSection:section];
    if ([source isKindOfClass:NSFetchedResultsController.class]) {
        NSArray *sections = ((NSFetchedResultsController *)source).sections;
        id<NSFetchedResultsSectionInfo> sectionInfo = sections.count ? [sections objectAtIndex:0] : nil;
        NSUInteger result = sectionInfo.numberOfObjects;
        return result;
    } else if ([source isKindOfClass:NSArray.class]) {
        NSUInteger result = ((NSArray *)source).count;
        return result;
    }
    return 1;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    id source = [self sourceForSection:indexPath.section];
    if ([source isKindOfClass:NSFetchedResultsController.class]) {
        id result = [(NSFetchedResultsController *)source objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        return result;
    } else if ([source isKindOfClass:NSArray.class]) {
        id result = [(NSArray *)source objectAtIndex:indexPath.row];
        return result;
    }
    return source;
}

- (id)sourceForSection:(NSUInteger)section
{
    NWComposedTableViewDataSourceHelper *helper = [helperForSection objectForKey:@(section)];
    if (!helper) {
        helper = [[NWComposedTableViewDataSourceHelper alloc] init];
        [helperForSection setObject:helper forKey:@(section)];
        id source = [delegate sourceForTableViewDataSource:self forSection:section];
        if (source) {
            helper.source = source;
            helper.dataSource = self;
            helper.tableView = tableView;
            helper.delegate = delegate;
            helper.section = section;
            helper.tableViewRowAnimationInsert = tableViewRowAnimationInsert;
            helper.tableViewRowAnimationDelete = tableViewRowAnimationDelete;
        }
        if ([source isKindOfClass:NSFetchedResultsController.class]) {
            NSFetchedResultsController *controller = (NSFetchedResultsController *)source;
            NWLogWarnIfNot(!controller.sectionNameKeyPath, @"Unexpected section key path: %@", controller.sectionNameKeyPath);
            controller.delegate = helper;
            NSError *error = nil;
            BOOL fetched = [controller performFetch:&error];
            if (!fetched || error) {
                NWLogWarn(@"Failed to fetch: %@", error);
            }
        }
    }
    return helper.source;
}

- (void)reloadDataForSection:(NSUInteger)section
{
    [helperForSection removeObjectForKey:@(section)];
    [tableView reloadData];
}

- (void)reloadData
{
    [helperForSection removeAllObjects];
    sectionCountCache = 0;
    [tableView reloadData];
}


#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView
{
    NWAssert(tableView == _tableView);
    NSUInteger result = self.sectionCount;
    return result;
}

- (NSInteger)tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section
{
    NWAssert(tableView == _tableView);
    NSUInteger result = [self countForSection:section];
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NWAssert(tableView == _tableView);
    Class tableViewCellClass = [UITableViewCell class];
    if ([delegate respondsToSelector:@selector(tableViewDataSource:cellClassForRowAtIndexPath:)]) {
        tableViewCellClass = [delegate tableViewDataSource:self cellClassForRowAtIndexPath:indexPath];
    }
    NSString *cellIdentifier = NSStringFromClass(tableViewCellClass);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
        UITableViewCellStyle tableViewCellStyle = UITableViewCellStyleDefault;
        if ([delegate respondsToSelector:@selector(tableViewDataSource:tableViewCellStyleForRowAtIndexPath:)]) {
            tableViewCellStyle = [delegate tableViewDataSource:self tableViewCellStyleForRowAtIndexPath:indexPath];
        }
        cell = [[tableViewCellClass alloc] initWithStyle:tableViewCellStyle reuseIdentifier:cellIdentifier];
	}
    
    id object = [self objectAtIndexPath:indexPath];
    [delegate tableViewDataSource:self configureCell:cell forRowAtIndexPath:indexPath withObject:object];
    
	return cell;
}

- (NSString *)tableView:(UITableView *)_tableView titleForHeaderInSection:(NSInteger)section
{
    NWAssert(tableView == _tableView);
    if ([delegate respondsToSelector:@selector(tableViewDataSource:titleForHeaderInSection:)]) {
        NSString *result = [delegate tableViewDataSource:self titleForHeaderInSection:section];
        return result;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)_tableView titleForFooterInSection:(NSInteger)section
{
    NWAssert(tableView == _tableView);
    if ([delegate respondsToSelector:@selector(tableViewDataSource:titleForFooterInSection:)]) {
        NSString *result = [delegate tableViewDataSource:self titleForFooterInSection:section];
        return result;
    }
    return nil;
}

@end


@implementation NWComposedTableViewDataSourceHelper

@synthesize dataSource, tableView, source, delegate, section;
@synthesize tableViewRowAnimationInsert, tableViewRowAnimationDelete;

- (void)dealloc
{
    if ([source isKindOfClass:NSFetchedResultsController.class]) {
        ((NSFetchedResultsController *)source).delegate = nil;
    }
}

#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    NWAssert(source == controller);
    [tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)_section forChangeType:(NSFetchedResultsChangeType)type
{
    NWAssert(source == controller);
    NWAssert(_section == 0);
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)object atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    NWAssert(source == controller);
    if (indexPath.section == 0 && newIndexPath.section == 0) {
        switch(type) {
            case NSFetchedResultsChangeInsert: {
                NSIndexPath *new = [NSIndexPath indexPathForRow:newIndexPath.row inSection:section];
                [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:new] withRowAnimation:tableViewRowAnimationInsert];
            } break;
            case NSFetchedResultsChangeDelete: {
                NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:section];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:tableViewRowAnimationDelete];
            } break;
            case NSFetchedResultsChangeUpdate: {
                NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:section];
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
                [delegate tableViewDataSource:dataSource configureCell:cell forRowAtIndexPath:path withObject:object];
            } break;
            case NSFetchedResultsChangeMove: {
                NSIndexPath *new = [NSIndexPath indexPathForRow:newIndexPath.row inSection:section];
                NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:section];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:tableViewRowAnimationDelete];
                [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:new] withRowAnimation:tableViewRowAnimationInsert];
            } break;
        }
    } else {
        NWLogWarn(@"Unexpected section in composed data source: %@ %@", indexPath, newIndexPath);
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    NWAssert(source == controller);
    [tableView endUpdates];
    if ([delegate respondsToSelector:@selector(tableViewDataSourceDidChangeContent:)]) {
        [delegate tableViewDataSourceDidChangeContent:dataSource];
    }
}

@end
