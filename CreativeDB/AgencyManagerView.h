//
//  AgencyManagerView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ManagerEngine.h"
#import "ManagerActionBar.h"

@protocol AgencyDataSource <NSObject>

- (NSString *) modelName;
- (NSNumber *) modelItem;
- (NSMutableDictionary *) fieldData;

@end

@interface AgencyManagerView : NSView 

@property (assign) id <AgencyDataSource> dataSource;
@property (nonatomic, strong) ManagerEngine *engine;
@property (nonatomic, strong) ManagerActionBar *actionBar;

- (void) createForm;
- (void) destroyForm;

@end
