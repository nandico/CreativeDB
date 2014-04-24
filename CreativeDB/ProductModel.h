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

@property (strong) NSNumber *pk;
@property (strong) ClientModel *client;
@property (strong) NSString *name;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (ProductModel *) objectWithResults:(FMResultSet *)results;
+ (ProductModel *) loadModel:(NSNumber *) pk;
+ (ProductModel *) loadModelByStringValue:(NSString *) stringValue;
+ (NSMutableArray *) loadAll;
+ (NSMutableArray *) loadFiltered;
+ (NSNumber *) modelCount;
+ (NSMutableArray *) loadByClientId:(NSNumber *) clientPK;

+ (NSString *) modelFilterName;
+ (void) setModelFilterName:(NSString *) filterName;

+ (NSNumber *) modelFilterValue;
+ (void) setModelFilterValue:(NSNumber *) filterNumber;

- (NSNumber *) next;
- (NSNumber *) previous;
+ (NSNumber *) first;
+ (NSNumber *) last;

- (void) save;
- (void) deleteModel;


@end
