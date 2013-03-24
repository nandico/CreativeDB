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

@property (assign) NSInteger pk;
@property (strong) NSString *name;
@property (strong) CategoryModel *category;

+ (SubcategoryModel *) objectWithResults:(FMResultSet *)results;
+ (SubcategoryModel *) loadModel:(NSInteger) pk;

@end
