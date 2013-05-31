//
//  CategoryManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/30/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerViewController.h"
#import "CategoryManagerView.h"

#define CATEGORY_MANAGER_UPDATE_LIST @"CATEGORY_MANAGER_UPDATE_LIST"

@interface CategoryManagerViewController : BaseManagerViewController <CategoryDataSource>

@property (nonatomic, strong) NSString *modelTitle;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;

@end
