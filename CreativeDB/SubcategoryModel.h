//
//  SubcategoryModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"
#import "CategoryModel.h"

@interface SubcategoryModel : BaseModel

@property (assign) NSNumber *pk;
@property (strong) NSString *name;
@property (strong) CategoryModel *category;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (SubcategoryModel *) objectWithResults:(FMResultSet *)results;
+ (SubcategoryModel *) loadModel:(NSNumber *) pk;

@end
