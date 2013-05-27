//
//  ProductManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/23/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerViewController.h"
#import "ProductManagerView.h"

#define PRODUCT_MANAGER_UPDATE_LIST @"PRODUCT_MANAGER_UPDATE_LIST"


@interface ProductManagerViewController : BaseManagerViewController <ProductDataSource>

@property (nonatomic, strong) NSString *modelTitle;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;

@end
