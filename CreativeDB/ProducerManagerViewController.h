//
//  ProducerManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/26/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerViewController.h"
#import "ProducerManagerView.h"

#define PRODUCER_MANAGER_UPDATE_LIST @"PRODUCER_MANAGER_UPDATE_LIST"
#define PRODUCER_MANAGER_UPDATE_VIEW @"PRODUCER_MANAGER_UPDATE_VIEW"


@interface ProducerManagerViewController : BaseManagerViewController <ProducerDataSource>

@property (nonatomic, strong) NSString *modelTitle;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;

@end
