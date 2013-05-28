//
//  ScoreModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/27/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface ScoreModel : BaseModel

@property (assign) NSNumber *pk;
@property (strong) NSNumber *origin;
@property (strong) NSNumber *entry;
@property (strong) NSNumber *festival;
@property (strong) NSNumber *year;
@property (strong) NSNumber *score;

+ (NSString *) tableName;
+ (void) setTableName: (NSString *) name;
+ (NSString *) fields;
+ (ScoreModel *) objectWithResults:(FMResultSet *)results;
+ (ScoreModel *) loadModel:(NSNumber *) pk;
+ (ScoreModel *) loadModelByStringValue:(NSString *) stringValue;
+ (NSMutableArray *) loadAll;
+ (void) resetScore:(NSString *) tableName;

- (void) save;
- (void) deleteModel;

@end
