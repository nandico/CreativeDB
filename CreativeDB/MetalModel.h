//
//  MetalModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface MetalModel : BaseModel

@property (assign) NSInteger pk;
@property (strong) NSString *name;

+ (MetalModel *) objectWithResults:(FMResultSet *)results;
+ (MetalModel *) loadModel:(NSInteger) pk;

@end
