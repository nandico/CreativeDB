//
//  RoleManagerView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ManagerEngine.h"
#import "ManagerActionBar.h"
#import "ManagerHeader.h"

@protocol RoleDataSource <NSObject>

- (NSString *) modelTitle;
- (NSString *) modelName;
- (NSNumber *) modelItem;
- (NSMutableDictionary *) fieldData;

@end

@interface RoleManagerView : NSView

@property (assign) id <RoleDataSource> dataSource;
@property (nonatomic, strong) ManagerEngine *engine;
@property (nonatomic, strong) ManagerHeader *header;
@property (nonatomic, strong) ManagerActionBar *actionBar;

- (void) createForm;
- (void) destroyForm;


@end
