//
//  CalendarTypeModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@interface CalendarTypeModel : BaseModel

@property (assign) NSNumber *pk;
@property (strong) NSString *name;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (CalendarTypeModel *) objectWithResults:(FMResultSet *)results;
+ (CalendarTypeModel *) loadModel:(NSNumber *) pk;

@end
