//
//  AgencyModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "GroupModel.h"

@interface AgencyModel : BaseModel

@property (assign) NSInteger pk;
@property (strong) NSString *type;
@property (strong) GroupModel *group;
@property (assign) NSInteger country;
@property (strong) NSString *name;

+ (AgencyModel *) objectWithResults:(FMResultSet *)results;

@end
