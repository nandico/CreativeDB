//
//  CreditManagerListViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 4/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BaseManagerListViewController.h"

@interface CreditManagerListViewController : BaseManagerListViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;

- (id)initWithOptions:(NSDictionary *) options;
- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView;
- (id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;

@end
