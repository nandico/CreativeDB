//
//  PersonManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerViewController.h"
#import "PersonManagerView.h"

#define PERSON_MANAGER_UPDATE_LIST @"PERSON_MANAGER_UPDATE_LIST"
#define PERSON_MANAGER_UPDATE_VIEW @"PERSON_MANAGER_UPDATE_VIEW"


@interface PersonManagerViewController : BaseManagerViewController <PersonDataSource>

@property (nonatomic, strong) NSString *modelTitle;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;

@end
