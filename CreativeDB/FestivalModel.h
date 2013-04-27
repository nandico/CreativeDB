//
//  FestivalModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface FestivalModel : BaseModel

@property (assign) NSNumber *pk;
@property (strong) NSString *name;
@property (strong) NSURL *siteURL;
@property (assign) NSInteger weight;
@property (strong) NSString *obs;
@property (assign) NSInteger classify;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (FestivalModel *) objectWithResults:(FMResultSet *)results;
+ (FestivalModel *) loadModel:(NSNumber *) pk;

@end
