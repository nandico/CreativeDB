//
//  ProductModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"
#import "ClientModel.h"

@interface ProductModel : BaseModel

@property (assign) NSInteger pk;
@property (strong) ClientModel *client;
@property (strong) NSString *name;

+ (ProductModel *) objectWithResults:(FMResultSet *)results;
+ (ProductModel *) loadModel:(NSInteger) pk;
+ (NSMutableArray *) loadAll;

@end
