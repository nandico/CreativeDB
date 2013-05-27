//
//  ProducerCreditManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/10/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerViewController.h"
#import "ProducerCreditManagerView.h"

#define PRODUCERCREDIT_MANAGER_UPDATE_LIST @"PRODUCER_CREDIT_MANAGER_UPDATE_LIST"

@interface ProducerCreditManagerViewController : BaseManagerViewController <ProducerCreditDataSource>

@property (nonatomic, strong) NSString *modelTitle;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSString *modelFilterName;
@property (nonatomic, strong) NSNumber *modelFilterValue;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;

@end
