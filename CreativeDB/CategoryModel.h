//
//  CategoryModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface CategoryModel : BaseModel

@property (assign) NSNumber *pk;
@property (strong) NSString *name;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (CategoryModel *) objectWithResults:(FMResultSet *)results;
+ (CategoryModel *) loadModel:(NSNumber *) pk;
+ (NSMutableArray *) loadAll;

@end
