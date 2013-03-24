//
//  TableModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface TableModel : BaseModel

@property (strong) NSString *type;
@property (strong) NSString *name;
@property (strong) NSString *tbl_name;
@property (assign) NSInteger rootpage;
@property (strong) NSString *sql;
@property (strong) NSMutableArray *columns;

+ (TableModel *) objectWithResults:(FMResultSet *)results;

@end
