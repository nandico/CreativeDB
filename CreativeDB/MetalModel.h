//
//  MetalModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface MetalModel : BaseModel 

@property (strong) NSNumber *pk;
@property (strong) NSString *name;
@property (strong) NSNumber *weight;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (MetalModel *) objectWithResults:(FMResultSet *)results;
+ (MetalModel *) loadModel:(NSNumber *) pk;
+ (NSMutableArray *) loadAll;
+ (MetalModel *) loadModelByStringValue:(NSString *) stringValue;

@end
