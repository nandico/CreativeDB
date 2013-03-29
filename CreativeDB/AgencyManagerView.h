//
//  AgencyManagerView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AgencyModel.h"
#import "ManagerFieldContainer.h"

@protocol AgencyDataSource <NSObject>

- (AgencyModel *)baseModel;

@end

@interface AgencyManagerView : NSView 

@property (assign) id <AgencyDataSource> dataSource;

- (void)createForm;

@end
