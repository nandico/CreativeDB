//
//  GroupModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface GroupModel : BaseModel

@property (assign) NSNumber *pk;
@property (strong) NSString *name;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (GroupModel *) objectWithResults:(FMResultSet *)results;
+ (GroupModel *) loadModel:(NSNumber *) pk;
+ (NSMutableArray *) loadAll;
+ (GroupModel *) loadModelByStringValue:(NSString *) stringValue;

@end
