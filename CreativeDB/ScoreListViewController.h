//
//  ScoreListViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerListViewController.h"
#import "ManagerEngine.h"
#import "EntryManagerCompleteViewController.h"
#import "ScoreListView.h"

@interface ScoreListViewController : BaseManagerListViewController  <NSTableViewDelegate, NSTableViewDataSource, ScoreListDataSource>

@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSString *modelFilterName;
@property (nonatomic, strong) NSNumber *modelFilterValue;
@property (nonatomic, strong) NSMutableDictionary *fieldData;


- (id)initWithOptions:(NSDictionary *) options;

@end
