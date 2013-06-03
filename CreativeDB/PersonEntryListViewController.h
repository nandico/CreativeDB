//
//  PersonEntryListViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/2/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerListViewController.h"

@interface PersonEntryListViewController : BaseManagerListViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, strong) NSNumber *modelItem;

- (id)initWithOptions:(NSDictionary *) options;

@end
