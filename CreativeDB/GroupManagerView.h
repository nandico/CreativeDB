//
//  GroupManagerView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/31/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ManagerEngine.h"

@protocol GroupDataSource <NSObject>

- (NSString *) modelTitle;
- (NSString *) modelName;
- (NSNumber *) modelItem;
- (NSMutableDictionary *) fieldData;

@end

@interface GroupManagerView : NSView

@property (assign) id <GroupDataSource> dataSource;
@property (nonatomic, strong) ManagerEngine *engine;
@property (nonatomic, strong) ManagerHeader *header;
@property (nonatomic, strong) ManagerActionBar *actionBar;


- (void) createForm;
- (void) destroyForm;

@end
