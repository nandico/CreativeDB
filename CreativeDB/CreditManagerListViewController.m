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

@property (nonatomic, strong) NSMutableArray *items;

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
    
    if( self.modelItem )
    {
        _items = [CreditModel loadByEntryId:self.modelItem];
    }
        
    [_tableView reloadData];

}
- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView
{
    if( _items )
    {
        return _items.count;
    }

    return 0;
}

- (id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{

    // get an existing cell with the MyView identifier if it exists
    NSTextField *result = [tableView makeViewWithIdentifier:@"MyView" owner:self];
    
    // There is no existing cell to reuse so we will create a new one
    if (result == nil) {
        
        // create the new NSTextField with a frame of the {0,0} with the width of the table
        // note that the height of the frame is not really relevant, the row-height will modify the height
        // the new text field is then returned as an autoreleased object
        result = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 100.0f, 30.0f)];
        
        // the identifier of the NSTextField instance is set to MyView. This
        // allows it to be re-used
        result.identifier = @"MyView";
    }
    
    // result is now guaranteed to be valid, either as a re-used cell
    // or as a new cell, so set the stringValue of the cell to the
    // nameArray value at row
    CreditModel *item = [_items objectAtIndex:row];
    
    result.stringValue = item.person.name;
    
    // return the result.
    return result;

}



@end
