//
//  AgencyModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"
#import "GroupModel.h"
#import "CountryModel.h"

@interface AgencyModel : BaseModel

@property (assign) NSNumber *pk;
@property (strong) NSString *type;
@property (strong) GroupModel *group;
@property (strong) CountryModel *country;
@property (strong) NSString *name;

+ (AgencyModel *) objectWithResults:(FMResultSet *)results;
+ (AgencyModel *) loadModel:(NSNumber *) pk;
+ (AgencyModel *) loadModelByStringValue:(NSString *) stringValue;
+ (NSMutableArray *) loadAll;

@end
