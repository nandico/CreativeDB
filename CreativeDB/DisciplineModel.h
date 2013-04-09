//
//  DisciplineModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface DisciplineModel : BaseModel

@property (assign) NSInteger pk;
@property (strong) NSString *name;

+ (DisciplineModel *) objectWithResults:(FMResultSet *)results;
+ (DisciplineModel *) loadModel:(NSNumber *) pk;


@end
