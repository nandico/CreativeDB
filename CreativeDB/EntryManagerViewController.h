//
//  EntryManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/30/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EntryManagerView.h"

@interface EntryManagerViewController : NSViewController <EntryDataSource>

@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSMutableDictionary *fieldData;


- (id)initWithOptions:(NSDictionary *)options;

@end
