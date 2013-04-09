//
//  ClientModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CountryModel.h"

@interface ClientModel : BaseModel

@property (assign) NSInteger pk;
@property (strong) CountryModel *country;
@property (strong) NSString *name;

+ (ClientModel *) objectWithResults:(FMResultSet *)results;
+ (ClientModel *) loadModel:(NSNumber *) pk;
+ (ClientModel *) loadModelByStringValue:(NSString *) stringValue;
+ (NSMutableArray *) loadAll;

@end
