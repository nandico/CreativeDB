//
//  AwardManagerListViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/13/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerListViewController.h"

@interface AwardManagerListViewController : BaseManagerListViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSString *modelFilterName;
@property (nonatomic, strong) NSNumber *modelFilterValue;

- (id)initWithOptions:(NSDictionary *) options;

@end
