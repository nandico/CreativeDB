//
//  GroupManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/31/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerViewController.h"
#import "GroupManagerView.h"

#define GROUP_MANAGER_UPDATE_LIST @"GROUP_MANAGER_UPDATE_LIST"
#define GROUP_MANAGER_UPDATE_VIEW @"GROUP_MANAGER_UPDATE_VIEW"

@interface GroupManagerViewController : BaseManagerViewController <GroupDataSource>

@property (nonatomic, strong) NSString *modelTitle;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;

@end
