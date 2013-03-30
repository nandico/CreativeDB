//
//  AgencyManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AgencyManagerView.h"
#import "AgencyModel.h"

@interface AgencyManagerViewController : NSViewController <AgencyDataSource>

@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;

- (id)initWithOptions:(NSDictionary *)options;

@end
