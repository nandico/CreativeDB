//
//  ProducerCreditManagerListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/11/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProducerCreditManagerListViewController.h"
#import "ProducerCreditManagerListView.h"
#import "ProducerCreditManagerViewController.h"
#import "ManagerEngine.h"
#import "ProducerCreditModel.h"

@interface ProducerCreditManagerListViewController ()

@property (nonatomic, strong) ProducerCreditManagerListView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@property (nonatomic, strong) NSScrollView *tableContainer;
@property (nonatomic, strong) NSTableView *tableView;

@property (nonatomic, strong) NSTableColumn *producerColumn;
@property (nonatomic, strong) NSTableColumn *disciplineColumn;

@property (nonatomic, strong) NSMutableArray *items;

@end


@implementation ProducerCreditManagerListViewController

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
        
        self.view = self.viewInstance = [[ProducerCreditManagerListView alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateList:)
                                                     name:PRODUCERCREDIT_MANAGER_UPDATE_LIST object:nil];
        
        
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
        _items = [ProducerCreditModel loadByEntryId:self.modelFilterValue];
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
        _items = [ProducerCreditModel loadByEntryId:self.modelItem];
    }
    
    _tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(10.0f, 10.0f, 500.0f, 250.0f)];
    _tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, 500.0f, 200.0f)];
    
    _producerColumn = [[NSTableColumn alloc] initWithIdentifier:@"producer"];
    _disciplineColumn = [[NSTableColumn alloc] initWithIdentifier:@"discipline"];
    
    [_producerColumn setWidth:252.0f];
    [_disciplineColumn setWidth:252.0f];
    
    [_producerColumn.headerCell setStringValue:@"Producer"];
    [_disciplineColumn.headerCell setStringValue:@"Discipline"];
    
    [_tableView addTableColumn:_producerColumn];
    [_tableView addTableColumn:_disciplineColumn];
    
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
    NSTextField *cell = [tableView makeViewWithIdentifier:@"ProducerCreditView" owner:self];
    
    if (nil == cell) {
        cell = [[NSTextField alloc] initWithFrame:CGRectZero];
        cell.identifier = @"ProducerCreditView";
        [cell setBezeled:NO];
        cell.backgroundColor = MLE_CONTAINER_COLOR;
        cell.wantsLayer = YES;
        cell.layer.cornerRadius = 4.0f;
    }
    
    ProducerCreditModel *item = [_items objectAtIndex:row];
    
    if( [tableColumn.identifier isEqualToString:@"producer"] )
    {
        [cell setStringValue:item.producer.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"discipline"] )
    {
        [cell setStringValue:item.discipline.name];
    }
    
    return cell;
}


@end
