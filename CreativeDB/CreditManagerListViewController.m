//
//  CreditManagerListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 4/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CreditManagerListViewController.h"
#import "CreditManagerListView.h"
#import "ManagerEngine.h"
#import "CreditModel.h"

@interface CreditManagerListViewController ()

@property (nonatomic, strong) CreditManagerListView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@property (nonatomic, strong) NSScrollView *tableContainer;
@property (nonatomic, strong) NSTableView *tableView;

@property (nonatomic, strong) NSTableColumn *personColumn;
@property (nonatomic, strong) NSTableColumn *roleColumn;

@end

@implementation CreditManagerListViewController

- (id)initWithOptions:(NSDictionary *) options
{
    self = [super init];
    if (self) {

        _options = options;
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_KEY] ) self.modelName = [self.options objectForKey:MLE_FIELDSET_MODEL_KEY];
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM] ) self.modelItem = [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM];
        
        self.view = self.viewInstance = [[CreditManagerListView alloc] init];
        
        
        [self createList];
    }
    
    return self;
}

- (void) createList
{
    _tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(10, 10, 380, 200)];
    _tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, 364, 200)];

    _personColumn = [[NSTableColumn alloc] initWithIdentifier:@"person"];
    _roleColumn = [[NSTableColumn alloc] initWithIdentifier:@"role"];
    
    [_personColumn setWidth:252.0f];
    [_roleColumn setWidth:198.0f];
    
    [_personColumn.headerCell setStringValue:@"Person"];
    [_roleColumn.headerCell setStringValue:@"Role"];

    [_tableView addTableColumn:_personColumn];
    [_tableView addTableColumn:_roleColumn];
    
    [_tableContainer setDocumentView:_tableView];
    [_tableContainer setHasVerticalScroller:YES];

    [self.view addSubview:_tableContainer];

    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    [_tableView reloadData];

}

/*

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView
{
    NSInteger teste = 100000;
    
    NSLog( @"number of rows! tableview %@", tableView );
    return teste;
    
    if( _modelItem )
    {
        return [[CreditModel loadByEntryId:_modelItem] count];
    }

    return 0;
}
*/

/*
- (id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
}
*/



@end
