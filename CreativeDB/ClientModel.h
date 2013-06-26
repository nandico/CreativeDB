//
//  ClientModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CountryModel.h"

@interface ClientModel : BaseModel

@property (strong) NSNumber *pk;
@property (strong) CountryModel *country;
@property (strong) NSString *name;
@property (strong, nonatomic) NSNumber *rankingGlobal;
@property (strong, nonatomic) NSNumber *rankingCountry;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (ClientModel *) objectWithResults:(FMResultSet *)results;
+ (ClientModel *) loadModel:(NSNumber *) pk;
+ (ClientModel *) loadModelByStringValue:(NSString *) stringValue;
+ (NSMutableArray *) loadAll;
+ (NSNumber *) modelCount;

- (NSNumber *) next;
- (NSNumber *) previous;
+ (NSNumber *) first;
+ (NSNumber *) last;

- (void) save;
- (void) deleteModel;

- (NSInteger) calculateRankGlobal:(NSNumber *) year;
- (NSInteger) calculateRankCountry:(NSNumber *) year;



@end
