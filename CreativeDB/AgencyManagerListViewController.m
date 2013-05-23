//
//  AgencyManagerListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/19/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AgencyManagerListViewController.h"
#import "BaseLayeredView.h"
#import "ManagerEngine.h"
#import "AgencyManagerViewController.h"
#import "AgencyModel.h"
#import "EntryManagerCompleteViewController.h"

@interface AgencyManagerListViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@property (nonatomic, strong) NSScrollView *tableContainer;
@property (nonatomic, strong) NSTableView *tableView;

@property (nonatomic, strong) NSTableColumn *nameColumn;
@property (nonatomic, strong) NSTableColumn *countryColumn;
@property (nonatomic, strong) NSTableColumn *groupColumn;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation AgencyManagerListViewController

- (id)initWithOptions:(NSDictionary *) options
{
    self = [super init];
    if (self) {
        
        _options = options;
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_KEY] )
            self.modelName = [self.options objectForKey:MLE_FIELDSET_MODEL_KEY];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM] )
            self.modelItem = [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERNAME] )
            self.modelFilterName = [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERNAME];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE] )
            self.modelFilterValue = [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE];
        
        self.view = self.viewInstance = [[BaseLayeredView alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateList:)
                                                     name:AGENCY_MANAGER_UPDATE_LIST object:nil];
        
        
        [self createList];
    }
    
    return self;
}

- (void) updateList:(NSNotification *) notification
{
    [self.viewInstance setHidden:NO];
    _items = [AgencyModel loadAll];
    [_tableView reloadData];
}


- (void) createList
{
    if( self.modelItem )
    {
        _items = [AgencyModel loadAll];
    }
    
    _tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, COMPLETE_VIEW_CONTAINER_LIST_HEIGHT)];
    _tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, 0)];
    
    _nameColumn = [[NSTableColumn alloc] initWithIdentifier:@"name"];
    _countryColumn = [[NSTableColumn alloc] initWithIdentifier:@"country"];
    _groupColumn = [[NSTableColumn alloc] initWithIdentifier:@"group"];
    
    [_nameColumn.headerCell setStringValue:@"Name"];
    [_countryColumn.headerCell setStringValue:@"Country"];
    [_groupColumn.headerCell setStringValue:@"Group"];
    
    [_nameColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 3.0f];
    [_countryColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 3.0f];
    [_groupColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 3.0f];
    
    [_tableView addTableColumn:_nameColumn];
    [_tableView addTableColumn:_countryColumn];
    [_tableView addTableColumn:_groupColumn];
    
    [_tableContainer setDocumentView:_tableView];
    [_tableContainer setHasVerticalScroller:YES];
    
    [self.view addSubview:_tableContainer];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    [_tableView reloadData];
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _items.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTextField *cell = [tableView makeViewWithIdentifier:@"AgencyView" owner:self];
    
    if (nil == cell) {
        cell = [[NSTextField alloc] initWithFrame:CGRectZero];
        cell.identifier = @"AgencyView";
        [cell setBezeled:NO];
        cell.backgroundColor = MLE_CONTAINER_COLOR;
        cell.wantsLayer = YES;
        cell.layer.cornerRadius = 4.0f;
    }
    
    AgencyModel *item = [_items objectAtIndex:row];
    
    if( [tableColumn.identifier isEqualToString:@"name"] )
    {
        [cell setStringValue:item.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"country"] )
    {
        [cell setStringValue:item.country.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"group"] )
    {
        [cell setStringValue:item.group.name];
    }
    
    return cell;
}
@end
