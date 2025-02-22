//
//  GroupModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"
#import "CountryModel.h"

@interface GroupModel : BaseModel

@property (strong) NSNumber *pk;
@property (strong) NSString *name;
@property (strong, nonatomic) CountryModel *country;
@property (strong, nonatomic) NSNumber *rankingGlobal;
@property (strong, nonatomic) NSNumber *rankingCountry;

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

- (NSMutableArray *) entries;

- (void) save;
- (void) deleteModel;

- (NSInteger) calculateRankGlobal:(NSNumber *) year;
- (NSInteger) calculateRankCountry:(NSNumber *) year;

@end
