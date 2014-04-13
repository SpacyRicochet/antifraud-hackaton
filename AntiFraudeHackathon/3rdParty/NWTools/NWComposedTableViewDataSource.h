//
//  NWComposedTableViewDataSource.h
//  NWTools
//
//  Created by Leonard van Driel
//  Copyright 2012 noodlewerk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@protocol NWComposedTableViewDataSourceDelegate;

@interface NWComposedTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, assign) id<NWComposedTableViewDataSourceDelegate> delegate;
@property (nonatomic) UITableViewRowAnimation tableViewRowAnimationInsert;
@property (nonatomic) UITableViewRowAnimation tableViewRowAnimationDelete;

- (id)initWithTableView:(UITableView *)tableView;

- (NSUInteger)sectionCount;
- (NSUInteger)countForSection:(NSUInteger)section;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

- (id)sourceForSection:(NSUInteger)section;
- (void)reloadDataForSection:(NSUInteger)section;
- (void)reloadData;

@end


@protocol NWComposedTableViewDataSourceDelegate <NSObject>

@required
- (NSUInteger)sectionCountForTableViewDataSource:(NWComposedTableViewDataSource *)dataSource;
- (id)sourceForTableViewDataSource:(NWComposedTableViewDataSource *)dataSource forSection:(NSUInteger)section;
- (void)tableViewDataSource:(NWComposedTableViewDataSource *)dataSource configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@optional
- (NSString *)tableViewDataSource:(NWComposedTableViewDataSource *)dataSource titleForHeaderInSection:(NSUInteger)section;
- (NSString *)tableViewDataSource:(NWComposedTableViewDataSource *)dataSource titleForFooterInSection:(NSUInteger)section;
- (Class)tableViewDataSource:(NWComposedTableViewDataSource *)dataSource cellClassForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCellStyle)tableViewDataSource:(NWComposedTableViewDataSource *)dataSource tableViewCellStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableViewDataSourceDidChangeContent:(NWComposedTableViewDataSource *)dataSource;

@end
