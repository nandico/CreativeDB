//
//  RoleManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerViewController.h"
#import "RoleManagerView.h"

#define ROLE_MANAGER_UPDATE_LIST @"ROLE_MANAGER_UPDATE_LIST"

@interface RoleManagerViewController : BaseManagerViewController <RoleDataSource>

@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;


@end
