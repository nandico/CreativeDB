//
//  RoleModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface RoleModel : BaseModel

@property (assign) NSInteger pk;
@property (strong) NSString *name;
@property (strong) NSString *obs;

+ (RoleModel *) objectWithResults:(FMResultSet *)results;
+ (RoleModel *) loadModel:(NSInteger) pk;


@end
