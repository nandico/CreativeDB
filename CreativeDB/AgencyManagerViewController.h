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
#import "BaseManagerViewController.h"

#define AGENCY_MANAGER_UPDATE_LIST @"AGENCY_MANAGER_UPDATE_LIST"

@interface AgencyManagerViewController : BaseManagerViewController <AgencyDataSource>

@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;

@end
