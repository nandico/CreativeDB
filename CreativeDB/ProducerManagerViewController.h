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


@interface ProducerManagerViewController : BaseManagerViewController <ProducerDataSource>

@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;

@end
