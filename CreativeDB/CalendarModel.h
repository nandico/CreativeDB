//
//  CalendarModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"
#import "FestivalModel.h"
#import "CalendarTypeModel.h"
#import "CategoryModel.h"

@interface CalendarModel : BaseModel

@property (assign) NSInteger pk;
@property (strong) FestivalModel *festival;
@property (strong) CalendarTypeModel *type;
@property (strong) CategoryModel *category;
@property (strong) NSDate *date;
@property (assign) NSInteger year;

+ (CalendarModel *) objectWithResults:(FMResultSet *)results;
+ (CalendarModel *) loadModel:(NSNumber *) pk;

@end
