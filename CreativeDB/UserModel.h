//
//  UserModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

@property (assign) NSNumber *pk;
@property (strong) NSString *fb_id;
@property (strong) NSString *tw_id;
@property (strong) NSString *name;
@property (strong) NSString *email;

+ (NSString *) tableName;
+ (UserModel *) objectWithResults:(FMResultSet *)results;
+ (UserModel *) loadModel:(NSNumber *) pk;

@end
