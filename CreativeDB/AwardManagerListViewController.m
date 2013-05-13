//
//  AwardManagerListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/13/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AwardManagerListViewController.h"
#import "AwardManagerListView.h"
#import "ManagerEngine.h"
#import "AwardManagerViewController.h"
#import "AwardModel.h"
#import "EntryManagerCompleteViewController.h"

@interface AwardManagerListViewController ()

@property (nonatomic, strong) AwardManagerListView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@property (nonatomic, strong) NSScrollView *tableContainer;
@property (nonatomic, strong) NSTableView *tableView;

@property (nonatomic, strong) NSTableColumn *metalColumn;
@property (nonatomic, strong) NSTableColumn *festivalColumn;
@property (nonatomic, strong) NSTableColumn *categoryColumn;
@property (nonatomic, strong) NSTableColumn *subcategoryColumn;
@property (nonatomic, strong) NSTableColumn *yearColumn;


@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation AwardManagerListViewController


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
        
        self.view = self.viewInstance = [[AwardManagerListView alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateList:)
                                                     name:AWARD_MANAGER_UPDATE_LIST object:nil];
        
        
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
        _items = [AwardModel loadByEntryId:self.modelFilterValue];
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
        _items = [AwardModel loadByEntryId:self.modelItem];
    }
    
    _tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, COMPLETE_VIEW_CONTAINER_LIST_HEIGHT)];
    _tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, 0)];
    
    /*
     @property (nonatomic, strong) NSTableColumn *metalColumn;
     @property (nonatomic, strong) NSTableColumn *festivalColumn;
     @property (nonatomic, strong) NSTableColumn *categoryColumn;
     @property (nonatomic, strong) NSTableColumn *subcategoryColumn;
     @property (nonatomic, strong) NSTableColumn *yearColumn;
     */
    
    _metalColumn = [[NSTableColumn alloc] initWithIdentifier:@"metal"];
    _festivalColumn = [[NSTableColumn alloc] initWithIdentifier:@"festival"];
    _categoryColumn = [[NSTableColumn alloc] initWithIdentifier:@"category"];
    _subcategoryColumn = [[NSTableColumn alloc] initWithIdentifier:@"subcategory"];
    _yearColumn = [[NSTableColumn alloc] initWithIdentifier:@"year"];
    
    //[_producerColumn setWidth:252.0f];
    //[_disciplineColumn setWidth:252.0f];
    
    [_metalColumn.headerCell setStringValue:@"Metal"];
    [_festivalColumn.headerCell setStringValue:@"Festival"];
    [_categoryColumn.headerCell setStringValue:@"Category"];
    [_subcategoryColumn.headerCell setStringValue:@"Subcategory"];
    [_yearColumn.headerCell setStringValue:@"Year"];
    
    [_tableView addTableColumn:_metalColumn];
    [_tableView addTableColumn:_festivalColumn];
    [_tableView addTableColumn:_categoryColumn];
    [_tableView addTableColumn:_subcategoryColumn];
    [_tableView addTableColumn:_yearColumn];
    
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
    NSTextField *cell = [tableView makeViewWithIdentifier:@"AwardView" owner:self];
    
    if (nil == cell) {
        cell = [[NSTextField alloc] initWithFrame:CGRectZero];
        cell.identifier = @"AwardView";
        [cell setBezeled:NO];
        cell.backgroundColor = MLE_CONTAINER_COLOR;
        cell.wantsLayer = YES;
        cell.layer.cornerRadius = 4.0f;
    }
    
    AwardModel *item = [_items objectAtIndex:row];
    
    if( [tableColumn.identifier isEqualToString:@"metal"] )
    {
        [cell setStringValue:item.metal.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"festival"] )
    {
        [cell setStringValue:item.festival.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"category"] )
    {
        [cell setStringValue:item.category.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"subcategory"] )
    {
        [cell setStringValue:item.subcategory.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"year"] )
    {
        [cell setStringValue:[item.year stringValue]];
    }
    
    return cell;
}

@end
