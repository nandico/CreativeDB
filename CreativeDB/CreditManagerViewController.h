//
//  CreditManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 4/22/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BaseManagerViewController.h"
#import "CreditManagerView.h"

#define CREDIT_MANAGER_UPDATE_LIST @"CREDIT_MANAGER_UPDATE_LIST"
#define CREDIT_MANAGER_UPDATE_VIEW @"CREDIT_MANAGER_UPDATE_VIEW"

@interface CreditManagerViewController : BaseManagerViewController <CreditDataSource>

@property (nonatomic, strong) NSString *modelTitle;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSString *modelFilterName;
@property (nonatomic, strong) NSNumber *modelFilterValue;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;

@end
