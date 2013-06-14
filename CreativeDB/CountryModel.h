//
//  CountryModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface CountryModel : BaseModel

@property (strong) NSNumber *pk;
@property (strong) NSString *iso;
@property (strong) NSString *language;
@property (assign) NSInteger numcode;
@property (strong) NSString *printable_name;
@property (strong) NSString *iso3;
@property (strong) NSString *name;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (CountryModel *) objectWithResults:(FMResultSet *)results;
+ (CountryModel *) loadModel:(NSNumber *) pk;
+ (CountryModel *) loadModelByStringValue:(NSString *) stringValue;
+ (NSMutableArray *) loadAll;
+ (NSMutableArray *) loadFiltered;

@end
