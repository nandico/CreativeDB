//
//  TableModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "TableModel.h"

@implementation TableModel

+ (TableModel *) objectWithResults:(FMResultSet *)results
{
    TableModel *object = [[TableModel alloc] init];
    object.type = [results stringForColumn:@"type"];
    object.name = [results stringForColumn:@"name"];
    object.tbl_name = [results stringForColumn:@"tbl_name"];
    object.rootpage = [results longForColumn:@"rootpage"];
    object.sql = [results stringForColumn:@"sql"];
    
    return object;
}

 
@end
