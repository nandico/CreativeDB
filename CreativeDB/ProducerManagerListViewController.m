//
//  ProducerManagerListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/26/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProducerManagerListViewController.h"
#import "BaseLayeredView.h"
#import "ManagerEngine.h"
#import "ProducerManagerViewController.h"
#import "ProducerModel.h"
#import "BaseManagerCompleteViewController.h"

@interface ProducerManagerListViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@property (nonatomic, strong) NSScrollView *tableContainer;
@property (nonatomic, strong) NSTableView *tableView;

@property (nonatomic, strong) NSTableColumn *countryColumn;
@property (nonatomic, strong) NSTableColumn *nameColumn;
@property (nonatomic, strong) NSTableColumn *siteURLColumn;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ProducerManagerListViewController

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
                                                     name:PRODUCER_MANAGER_UPDATE_LIST object:nil];
        
        
        [self createList];
    }
    
    return self;
}

- (void) updateList:(NSNotification *) notification
{
    [self.viewInstance setHidden:NO];
    _items = [ProducerModel loadAll];
    [_tableView reloadData];
}


- (void) createList
{
    if( self.modelItem )
    {
        _items = [ProducerModel loadAll];
    }
    
    _tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, COMPLETE_VIEW_CONTAINER_LIST_HEIGHT)];
    _tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, 0)];

    _countryColumn = [[NSTableColumn alloc] initWithIdentifier:@"country"];
    _nameColumn = [[NSTableColumn alloc] initWithIdentifier:@"name"];
    _siteURLColumn = [[NSTableColumn alloc] initWithIdentifier:@"siteURL"];

    [_countryColumn.headerCell setStringValue:@"Country"];
    [_nameColumn.headerCell setStringValue:@"Name"];
    [_siteURLColumn.headerCell setStringValue:@"Site URL"];
    
    [_countryColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 3.0f];
    [_nameColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 3.0];
    [_siteURLColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 3.0];
    
    [_tableView addTableColumn:_countryColumn];
    [_tableView addTableColumn:_nameColumn];
    [_tableView addTableColumn:_siteURLColumn];
    
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
    
    NSTextField *cell = [tableView makeViewWithIdentifier:@"RoleView" owner:self];
    
    if (nil == cell) {
        cell = [[NSTextField alloc] initWithFrame:CGRectZero];
        cell.identifier = @"RoleView";
        [cell setBezeled:NO];
        cell.backgroundColor = MLE_CONTAINER_COLOR;
        cell.wantsLayer = YES;
        cell.layer.cornerRadius = 4.0f;
    }
    
    ProducerModel *item = [_items objectAtIndex:row];
    
    if( [tableColumn.identifier isEqualToString:@"name"] )
    {
        if( item.name ) [cell setStringValue:item.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"country"] )
    {
        if( item.country ) [cell setStringValue:item.country.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"siteURL"] )
    {
        if( item.siteURL ) [cell setStringValue:[item.siteURL absoluteString]];
    }
    
    return cell;
}

@end
