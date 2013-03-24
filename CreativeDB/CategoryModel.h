//
//  CategoryModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface CategoryModel : BaseModel

@property (assign) NSInteger pk;
@property (strong) NSString *name;

+ (CategoryModel *) objectWithResults:(FMResultSet *)results;
+ (CategoryModel *) loadModel:(NSInteger) pk;

@end
