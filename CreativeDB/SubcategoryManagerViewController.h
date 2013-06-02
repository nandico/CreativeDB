//
//  SubcategoryManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/30/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerViewController.h"
#import "SubcategoryManagerView.h"

#define SUBCATEGORY_MANAGER_UPDATE_LIST @"SUBCATEGORY_MANAGER_UPDATE_LIST"
#define SUBCATEGORY_MANAGER_UPDATE_VIEW @"SUBCATEGORY_MANAGER_UPDATE_VIEW"

@interface SubcategoryManagerViewController : BaseManagerViewController <SubcategoryDataSource>

@property (nonatomic, strong) NSString *modelTitle;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;

@end
