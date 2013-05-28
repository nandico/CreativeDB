//
//  ScoreManagerListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ScoreManagerListViewController.h"
#import "ScoreModel.h"

@interface ScoreManagerListViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@property (nonatomic, strong) NSScrollView *tableContainer;
@property (nonatomic, strong) NSTableView *tableView;

@property (nonatomic, strong) NSTableColumn *personColumn;
@property (nonatomic, strong) NSTableColumn *countryColumn;
@property (nonatomic, strong) NSTableColumn *scoreColumn;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ScoreManagerListViewController

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
        
        [ScoreModel setTableName:@"aa_person_score"];
        
        [self.viewInstance setHidden:NO];
        _items = [ScoreModel loadRankingByTableName:@"aa_person_score"];
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
        [ScoreModel setTableName:@"aa_person_score"];
        _items = [ScoreModel loadRankingByTableName:@"aa_person_score"];
    }
    
    _tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, COMPLETE_VIEW_CONTAINER_HEIGHT)];
    _tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, COMPLETE_VIEW_CONTAINER_HEIGHT)];
    
    [_tableView setRowHeight:50.0f];
    
    _personColumn = [[NSTableColumn alloc] initWithIdentifier:@"person"];
    _countryColumn = [[NSTableColumn alloc] initWithIdentifier:@"country"];
    _scoreColumn = [[NSTableColumn alloc] initWithIdentifier:@"score"];
    
    [_personColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 3.0f];
    [_countryColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 3.0f];
    [_scoreColumn setWidth:COMPLETE_VIEW_CONTAINER_LIST_WIDTH / 3.0f];
    
    [_personColumn.headerCell setStringValue:@"Person"];
    [_countryColumn.headerCell setStringValue:@"Country"];
    [_scoreColumn.headerCell setStringValue:@"Score"];
    
    [_tableView addTableColumn:_personColumn];
    [_tableView addTableColumn:_countryColumn];
    [_tableView addTableColumn:_scoreColumn];
    
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
    NSTextField *cell = [tableView makeViewWithIdentifier:@"ScoreView" owner:self];
    
    if (nil == cell) {
        cell = [[NSTextField alloc] initWithFrame:CGRectZero];
        cell.identifier = @"ScoreView";
        [cell setBezeled:NO];
        cell.backgroundColor = MLE_CONTAINER_COLOR;
        cell.wantsLayer = YES;
        cell.layer.cornerRadius = 4.0f;
        
        
        NSView *test = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 10.0f, 10.0f)];
        test.wantsLayer = YES;
        test.layer.backgroundColor = [[NSColor redColor] CGColor];
        
        [cell addSubview:test];
    }
    
    ScoreModel *item = [_items objectAtIndex:row];
    
    if( [tableColumn.identifier isEqualToString:@"person"] )
    {
        [cell setStringValue:item.person.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"country"] )
    {
        [cell setStringValue:item.person.country.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"score"] )
    {
        [cell setStringValue:[item.score stringValue]];
    }
    
    return cell;
}


@end
