//
//  RoleModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface RoleModel : BaseModel

@property (assign) NSNumber *pk;
@property (strong) NSString *name;
@property (strong) NSString *obs;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (RoleModel *) objectWithResults:(FMResultSet *)results;
+ (RoleModel *) loadModel:(NSNumber *) pk;
+ (RoleModel *) loadModelByStringValue:(NSString *) stringValue;
+ (NSMutableArray *) loadAll;

- (NSNumber *) next;
- (NSNumber *) previous;
+ (NSNumber *) first;
+ (NSNumber *) last;

- (void) save;
- (void) deleteModel;

@end
