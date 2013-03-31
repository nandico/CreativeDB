//
//  EntryManagerView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/30/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol EntryDataSource <NSObject>

- (NSString *) modelName;
- (NSNumber *) modelItem;

@end

@interface EntryManagerView : NSView

@property (assign) id <EntryDataSource> dataSource;

- (void)createForm;

@end
