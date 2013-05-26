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

@protocol RoleDataSource <NSObject>

- (NSString *) modelName;
- (NSNumber *) modelItem;
- (NSMutableDictionary *) fieldData;

@end

@interface RoleManagerView : NSView

@property (assign) id <RoleDataSource> dataSource;
@property (nonatomic, strong) ManagerEngine *engine;
@property (nonatomic, strong) ManagerActionBar *actionBar;

- (void) createForm;
- (void) destroyForm;


@end
