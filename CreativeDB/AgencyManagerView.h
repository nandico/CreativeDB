//
//  AgencyManagerView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol AgencyDataSource <NSObject>

- (NSString *) modelName;
- (NSNumber *) modelItem;
- (NSMutableDictionary *) fieldData;

@end

@interface AgencyManagerView : NSView 

@property (assign) id <AgencyDataSource> dataSource;

- (void) createForm;
- (void) destroyForm;

@end
