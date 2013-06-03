//
//  PersonEntryListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/2/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonEntryListViewController.h"
#import "BaseLayeredView.h"
#import "ManagerEngine.h"
#import "BaseManagerCompleteViewController.h"
#import "PersonModel.h"
#import "EntryModel.h"
#import "PersonManagerViewController.h"
#import "AwardModel.h"

@interface PersonEntryListViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@property (nonatomic, strong) NSScrollView *tableContainer;
@property (nonatomic, strong) NSTableView *tableView;

@property (nonatomic, strong) NSTableColumn *yearColumn;
@property (nonatomic, strong) NSTableColumn *agencyColumn;
@property (nonatomic, strong) NSTableColumn *entryColumn;
@property (nonatomic, strong) NSTableColumn *awardsColumn;

@property (nonatomic, strong) PersonModel *person;

@end

@implementation PersonEntryListViewController

- (id)initWithOptions:(NSDictionary *) options
{
    self = [super init];
    if (self) {
        
        _options = options;
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM] )
            self.modelItem = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_ITEM]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateView:)
                                                     name:PERSON_MANAGER_UPDATE_VIEW object:nil];        
        
        self.view = self.viewInstance = [[BaseLayeredView alloc] init];
        
        [self createList];
    }
    
    return self;
}

- (void) updateView:(NSNotification *) notification
{
    if( notification )
    {
        _person = [notification.userInfo objectForKey:MLE_FIELDSET_MODEL_ITEM];
        self.modelItem = _person.pk;
        [_tableView reloadData];
    }
    else if( self.modelItem )
    {
        _person = [PersonModel loadModel:self.modelItem];
        [_tableView reloadData];
    }
}

- (void) createList
{
    if( self.modelItem )
    {
        _person = [PersonModel loadModel:self.modelItem];
    }
    
    _tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, COMPLETE_VIEW_CONTAINER_BIGLIST_HEIGHT)];
    _tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_LIST_WIDTH, COMPLETE_VIEW_CONTAINER_BIGLIST_HEIGHT)];
    
    _yearColumn = [[NSTableColumn alloc] initWithIdentifier:@"year"];
    _agencyColumn = [[NSTableColumn alloc] initWithIdentifier:@"agency"];
    _entryColumn = [[NSTableColumn alloc] initWithIdentifier:@"entry"];
    _awardsColumn = [[NSTableColumn alloc] initWithIdentifier:@"awards"];
    
    [_yearColumn setWidth:10.0f / 100.0f * COMPLETE_VIEW_CONTAINER_LIST_WIDTH];
    [_agencyColumn setWidth:25.0f / 100.0f * COMPLETE_VIEW_CONTAINER_LIST_WIDTH];
    [_entryColumn setWidth:25.0f / 100.0f * COMPLETE_VIEW_CONTAINER_LIST_WIDTH];
    [_awardsColumn setWidth:40.0f / 100.0f * COMPLETE_VIEW_CONTAINER_LIST_WIDTH];
    
    [_yearColumn.headerCell setStringValue:@"Year"];
    [_agencyColumn.headerCell setStringValue:@"Agency"];
    [_entryColumn.headerCell setStringValue:@"Entry"];
    [_awardsColumn.headerCell setStringValue:@"Awards"];
    
    [_tableView addTableColumn:_yearColumn];
    [_tableView addTableColumn:_agencyColumn];
    [_tableView addTableColumn:_entryColumn];
    [_tableView addTableColumn:_awardsColumn];
    
    [_tableView setRowHeight:220.0f];
    
    [_tableContainer setDocumentView:_tableView];
    [_tableContainer setHasVerticalScroller:YES];
    
    [self.view addSubview:_tableContainer];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    [_tableView reloadData];
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [_person.entries count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTextField *cell = [tableView makeViewWithIdentifier:@"PersonEntryView" owner:self];
    
    if (nil == cell) {
        cell = [[NSTextField alloc] initWithFrame:CGRectZero];
        cell.identifier = @"PersonEntryView";
        [cell setBezeled:NO];
        cell.backgroundColor = MLE_CONTAINER_COLOR;
        cell.wantsLayer = YES;
        cell.layer.cornerRadius = 4.0f;
    }
    
    EntryModel *item = [_person.entries objectAtIndex:row];
    
    [cell setFont:MLE_REGULARTABLE_FONT];
    
    if( [tableColumn.identifier isEqualToString:@"year"] )
    {
        [cell setStringValue:[item.year stringValue]];
    }
    else if( [tableColumn.identifier isEqualToString:@"agency"] )
    {
        [cell setStringValue:item.agency.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"entry"] )
    {
        [cell setStringValue:item.name];
    }
    else if( [tableColumn.identifier isEqualToString:@"awards"] )
    {
        [cell setFont:MLE_SMALLTABLE_FONT];
        
        NSMutableString *awards = [[NSMutableString alloc] init];
        for( AwardModel *award in item.awards )
        {
            [awards appendString:[NSString stringWithFormat:@">> %@ - %@ \n%@\n%@\n\n", award.festival.name, award.metal.name, award.category.name, award.subcategory.name ]];
        }
        
        [cell setStringValue:awards];
    }
    
    return cell;
}


@end
