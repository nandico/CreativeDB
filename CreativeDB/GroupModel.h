//
//  GroupModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface GroupModel : BaseModel

@property (strong) NSNumber *pk;
@property (strong) NSString *name;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (GroupModel *) objectWithResults:(FMResultSet *)results;
+ (GroupModel *) loadModel:(NSNumber *) pk;
+ (NSMutableArray *) loadAll;
+ (NSNumber *) modelCount;
+ (NSNumber *) modelActiveCount;
+ (NSMutableArray *) loadFiltered;
+ (GroupModel *) loadModelByStringValue:(NSString *) stringValue;

- (NSNumber *) next;
- (NSNumber *) previous;
+ (NSNumber *) first;
+ (NSNumber *) last;

- (void) save;
- (void) deleteModel;

@end
