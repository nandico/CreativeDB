//
//  ProductManagerListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/23/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProductManagerListViewController.h"
#import "BaseLayeredView.h"
#import "ManagerEngine.h"
#import "ProductManagerViewController.h"
#import "ProductModel.h"
#import "BaseManagerCompleteViewController.h"

@interface ProductManagerListViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@property (nonatomic, strong) NSScrollView *tableContainer;
@property (nonatomic, strong) NSTableView *tableView;

@property (nonatomic, strong) NSTableColumn *nameColumn;
@property (nonatomic, strong) NSTableColumn *clientColumn;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ProductManagerListViewController

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
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateList:)
                                                     name:PRODUCT_MANAGER_UPDATE_LIST object:nil];
        
        
        [self createList];
    }
    
    return self;
}

- (void) updateList:(NSNotification *) notification
{
    NSNumber *modelFilterValue = [notification.userInfo objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE];
    
    if( modelFilterValue != (id)[NSNull null] )
    {
        self.modelFilterValue = modelFilterValue;
        
        [self.viewInstance setHidden:NO];
        _items = [ProductModel loadByClientId:self.modelFilterValue];
        [_tableView reloadData];
    }
    else
    {
        [self.viewInstance setHidden:YES];
    }
}


- (void) createList
{
    if( self.modelFilterValue )
    {
        _items = [ProductModel loadByClientId:self.modelFilterValue];
    }
        
    _tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, COMPLETE_VIEW_CONTAINER_LIST_HEIGHT)];
    _tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, 0)];
    
    _nameColumn = [[NSTableColumn alloc] initWithIdentifier:@"name"];
    _clientColumn = [[NSTableColumn alloc] initWithIdentifier:@"client"];
    
    [_nameColumn.headerCell setStringValue:@"Name"];
    [_clientColumn.headerCell setStringValue:@"Client"];
    
    [_nameColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 2.0f];
    [_clientColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 2.0];
    
    [_tableView addTableColumn:_nameColumn];
    [_tableView addTableColumn:_clientColumn];
    
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

- (void)tableViewSelectionDidChange:(NSNotification *) notification
{
    NSIndexSet *selectedIndexes = [_tableView selectedRowIndexes];
    NSNumber *firstIndex = [NSNumber numberWithUnsignedLong:selectedIndexes.firstIndex];
    
    if( firstIndex )
    {
        ProductModel *item = [_items objectAtIndex:[firstIndex integerValue]];
        NSDictionary *updateMessage = [NSDictionary dictionaryWithObject:item forKey:MLE_FIELDSET_MODEL_ITEM];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:PRODUCT_MANAGER_UPDATE_VIEW
                                                            object:self
                                                          userInfo:updateMessage];
        
    }
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    
    NSTextField *cell = [tableView makeViewWithIdentifier:@"ProductView" owner:self];
    
    if (nil == cell) {
        cell = [[NSTextField alloc] initWithFrame:CGRectZero];
        cell.identifier = @"ProductView";
        [cell setBezeled:NO];
        cell.backgroundColor = MLE_CONTAINER_COLOR;
        cell.wantsLayer = YES;
        cell.layer.cornerRadius = 4.0f;
    }
    
    ProductModel *item = [_items objectAtIndex:row];
    
    if( [tableColumn.identifier isEqualToString:@"name"] )
    {
        if( item.name ) [cell setStringValue:item.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"client"] )
    {
        if( item.client.name ) [cell setStringValue:item.client.name];
    }
    
    return cell;
}

@end
