//
//  CreditManagerListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 4/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CreditManagerListViewController.h"
#import "CreditManagerListView.h"

@interface CreditManagerListViewController ()

@property (nonatomic, strong) CreditManagerListView *viewInstance;

@end

@implementation CreditManagerListViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[CreditManagerListView alloc] init];
        
        [self createList];
    }
    
    return self;
}

- (void) createList
{
    // create a table view and a scroll view
    NSScrollView * tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(10, 10, 380, 200)];
    NSTableView * tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, 364, 200)];
    // create columns for our table
    NSTableColumn * column1 = [[NSTableColumn alloc] initWithIdentifier:@"Col1"];
    NSTableColumn * column2 = [[NSTableColumn alloc] initWithIdentifier:@"Col2"];
    [column1 setWidth:252];
    [column2 setWidth:198];
    // generally you want to add at least one column to the table view.
    [tableView addTableColumn:column1];
    [tableView addTableColumn:column2];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView reloadData];
    // embed the table view in the scroll view, and add the scroll view
    // to our window.
    [tableContainer setDocumentView:tableView];
    [tableContainer setHasVerticalScroller:YES];
    [self.view addSubview:tableContainer];
}

@end
