//
//  CalendarTypeModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface CalendarTypeModel : BaseModel

@property (assign) NSInteger pk;
@property (strong) NSString *name;

+ (CalendarTypeModel *) objectWithResults:(FMResultSet *)results;
+ (CalendarTypeModel *) loadModel:(NSInteger) pk;

@end
