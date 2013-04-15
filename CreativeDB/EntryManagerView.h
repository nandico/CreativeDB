//
//  EntryManagerView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/30/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ManagerFieldContainer.h"
#import "ManagerActionBar.h"
#import "ManagerEngine.h"
#import "BaseManagerView.h"

@protocol EntryDataSource <NSObject>

- (NSString *) modelName;
- (NSNumber *) modelItem;
- (NSMutableDictionary *) fieldData;

@end

@interface EntryManagerView : NSView

@property (strong) id <EntryDataSource> dataSource;

- (void) createForm;
- (void) destroyForm;

@end
