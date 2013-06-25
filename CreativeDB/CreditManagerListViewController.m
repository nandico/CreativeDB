//
//  CreditManagerListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 4/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CreditManagerListViewController.h"
#import "BaseLayeredView.h"
#import "CreditManagerViewController.h"
#import "ManagerEngine.h"
#import "CreditModel.h"
#import "EntryManagerCompleteViewController.h"

@interface CreditManagerListViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@property (nonatomic, strong) NSScrollView *tableContainer;
@property (nonatomic, strong) NSTableView *tableView;

@property (nonatomic, strong) NSTableColumn *personColumn;
@property (nonatomic, strong) NSTableColumn *roleColumn;
@property (nonatomic, strong) NSTableColumn *producerColumn;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation CreditManagerListViewController

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
                                                     name:CREDIT_MANAGER_UPDATE_LIST object:nil];

        
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
        _items = [CreditModel loadByEntryId:self.modelFilterValue];
        [_tableView reloadData];
    }
    else
    {
        [self.viewInstance setHidden:YES];
    }
}


- (void) createList
{
    if( self.modelItem )
    {
        _items = [CreditModel loadByEntryId:self.modelItem];
    }
    
    _tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, COMPLETE_VIEW_CONTAINER_LIST_HEIGHT)];
    _tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, 200.0f)];

    _personColumn = [[NSTableColumn alloc] initWithIdentifier:@"person"];
    _roleColumn = [[NSTableColumn alloc] initWithIdentifier:@"role"];
    _producerColumn = [[NSTableColumn alloc] initWithIdentifier:@"producer"];
    
    [_personColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 3.0f];
    [_roleColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 3.0f];
    [_producerColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 3.0f];
    
    [_personColumn.headerCell setStringValue:@"Person"];
    [_roleColumn.headerCell setStringValue:@"Role"];
    [_producerColumn.headerCell setStringValue:@"Company"];    

    [_tableView addTableColumn:_personColumn];
    [_tableView addTableColumn:_roleColumn];
    [_tableView addTableColumn:_producerColumn];
    
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
        CreditModel *item = [_items objectAtIndex:[firstIndex integerValue]];
        NSDictionary *updateMessage = [NSDictionary dictionaryWithObject:item forKey:MLE_FIELDSET_MODEL_ITEM];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CREDIT_MANAGER_UPDATE_VIEW
                                                            object:self
                                                          userInfo:updateMessage];
        
    }
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{   
    NSTextField *cell = [tableView makeViewWithIdentifier:@"CreditView" owner:self];
    
    if (nil == cell) {
        cell = [[NSTextField alloc] initWithFrame:CGRectZero];
        cell.identifier = @"CreditView";
        [cell setBezeled:NO];
        cell.backgroundColor = MLE_CONTAINER_COLOR;
        cell.wantsLayer = YES;
        cell.layer.cornerRadius = 4.0f;
    }
    
    CreditModel *item = [_items objectAtIndex:row];
 
    if( [tableColumn.identifier isEqualToString:@"person"] )
    {
        [cell setStringValue:item.person.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"role"] )
    {
        [cell setStringValue:item.role.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"producer"] )
    {
        if( item.producer )
        {
            [cell setStringValue:item.producer.name];
        }
        else
        {
            [cell setStringValue:item.entry.agency.name];
        }
    }
    
    return cell;
}

@end
