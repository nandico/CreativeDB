//
//  EntryManagerListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/2/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryManagerListViewController.h"
#import "BaseLayeredView.h"
#import "ManagerEngine.h"
#import "EntryModel.h"
#import "BaseManagerCompleteViewController.h"
#import "EntryManagerViewController.h"
#import "AwardModel.h"

@interface EntryManagerListViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@property (nonatomic, strong) NSScrollView *tableContainer;
@property (nonatomic, strong) NSTableView *tableView;

@property (nonatomic, strong) NSTableColumn *nameColumn;
@property (nonatomic, strong) NSTableColumn *agencyColumn;
@property (nonatomic, strong) NSTableColumn *awardsColumn;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation EntryManagerListViewController

- (id)initWithOptions:(NSDictionary *) options
{
    self = [super init];
    if (self) {
        
        _options = options;
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_KEY] )
            self.modelName = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_KEY]];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM] )
            self.modelItem = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_ITEM]];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERNAME] )
            self.modelFilterName = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_FILTERNAME]];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE] )
            self.modelFilterValue = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE]];
        
        self.view = self.viewInstance = [[BaseLayeredView alloc] init];
        
        self.modelItem = @1;
        
        [self createHeader];
        
        [self createList];
    }
    
    return self;
}

- (void) createList
{
    _items = [EntryModel loadAll];
    
    _tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH, COMPLETE_VIEW_CONTAINER_MEDIUMLIST_HEIGHT)];
    _tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH, COMPLETE_VIEW_CONTAINER_MEDIUMLIST_HEIGHT)];
    
    [_tableView setRowHeight:50.0f];
    
    _nameColumn = [[NSTableColumn alloc] initWithIdentifier:@"name"];
    _agencyColumn = [[NSTableColumn alloc] initWithIdentifier:@"agency"];
    _awardsColumn = [[NSTableColumn alloc] initWithIdentifier:@"awards"];
    
    [_nameColumn setWidth:COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH / 3.0f];
    [_agencyColumn setWidth:COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH / 3.0f];
    [_awardsColumn setWidth:COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH / 3.0f];
 
    [_nameColumn.headerCell setStringValue:@"Name"];
    [_agencyColumn.headerCell setStringValue:@"Agency"];
    [_awardsColumn.headerCell setStringValue:@"Awards"];
    
    [_tableView addTableColumn:_nameColumn];
    [_tableView addTableColumn:_agencyColumn];
    [_tableView addTableColumn:_awardsColumn];
    
    [_tableContainer setDocumentView:_tableView];
    [_tableContainer setHasVerticalScroller:YES];
    
    [self.view addSubview:_tableContainer];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    [_tableView reloadData];
    
}

- (void) createHeader
{
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _items.count;
}

- (void)tableViewSelectionDidChange:(NSNotification *) notification
{
    NSIndexSet *selectedIndexes = [_tableView selectedRowIndexes];
    NSNumber *firstIndex = [NSNumber numberWithUnsignedLong:selectedIndexes.firstIndex];
    
    if( firstIndex )
    {
        EntryModel *item = [_items objectAtIndex:[firstIndex integerValue]];
        NSDictionary *updateMessage = [NSDictionary dictionaryWithObject:item forKey:MLE_FIELDSET_MODEL_ITEM];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ENTRY_MANAGER_UPDATE_VIEW
                                                            object:self
                                                          userInfo:updateMessage];
        
    }
}


- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTextField *cell = [tableView makeViewWithIdentifier:@"EntryView" owner:self];
    
    if (nil == cell) {
        cell = [[NSTextField alloc] initWithFrame:CGRectZero];
        cell.identifier = @"EntryView";
        [cell setBezeled:NO];
        cell.backgroundColor = MLE_CONTAINER_COLOR;
        cell.wantsLayer = YES;
        cell.layer.cornerRadius = 4.0f;
    }
    
    EntryModel *item = [_items objectAtIndex:row];
 
    [cell setFont:MLE_REGULARTABLE_FONT];
    
    if( [tableColumn.identifier isEqualToString:@"name"] )
    {
        [cell setStringValue:item.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"agency"] )
    {
        [cell setStringValue:item.agency.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"awards"] )
    {
        [cell setFont:MLE_SMALLTABLE_FONT];
        
        NSMutableString *awards = [[NSMutableString alloc] init];
        for( AwardModel *award in item.awards )
        {
            [awards appendString:[NSString stringWithFormat:@">> %@ : %@ - %@ \n", award.year, award.festival.name, award.metal.name ]];
        }
        
        [cell setStringValue:awards];
    }
    
    return cell;
}


@end
