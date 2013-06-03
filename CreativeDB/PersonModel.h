//
//  PersonModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"
#import "CountryModel.h"

@interface PersonModel : BaseModel

@property (assign) NSNumber *pk;
@property (strong) CountryModel *country;
@property (strong) NSString *name;
@property (strong) NSURL *portfolioURL;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (PersonModel *) objectWithResults:(FMResultSet *)results;
+ (PersonModel *) loadModel:(NSNumber *) pk;
+ (NSMutableArray *) loadAll;

- (NSMutableArray *) entries;

- (NSNumber *) next;
- (NSNumber *) previous;
+ (NSNumber *) first;
+ (NSNumber *) last;

- (void) save;
- (void) deleteModel;

@end
