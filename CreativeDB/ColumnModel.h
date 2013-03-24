//
//  ColumnModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface ColumnModel : BaseModel

@property (assign) NSInteger cid;
@property (strong) NSString *name;
@property (strong) NSString *type;
@property (assign) BOOL notnull;
@property (strong) NSString *dflt_value;
@property (assign) BOOL pk;

+ (ColumnModel *) objectWithResults:(FMResultSet*)results;

@end
