//
//  AwardManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/12/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerViewController.h"
#import "AwardManagerView.h"

#define AWARD_MANAGER_UPDATE_LIST @"AWARD_MANAGER_UPDATE_LIST"
#define AWARD_MANAGER_UPDATE_VIEW @"AWARD_MANAGER_UPDATE_VIEW"

@interface AwardManagerViewController : BaseManagerViewController <AwardDataSource>

@property (nonatomic, strong) NSString *modelTitle;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSString *modelFilterName;
@property (nonatomic, strong) NSNumber *modelFilterValue;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;

@end
