//
//  EntryManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/30/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EntryManagerView.h"
#import "BaseManagerViewController.h"

#define ENTRY_MANAGER_UPDATE_CREDITS @"ENTRY_MANAGER_UPDATE_CREDITS"


@interface EntryManagerViewController : BaseManagerViewController <EntryDataSource>

@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;

@end
