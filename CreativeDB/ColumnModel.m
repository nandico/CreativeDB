//
//  ColumnModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ColumnModel.h"

@implementation ColumnModel

+ (ColumnModel *) objectWithResults:(FMResultSet*)results
{
    ColumnModel *object = [[ColumnModel alloc] init];
    object.cid = [results intForColumn:@"cid"];
    object.name = [results stringForColumn:@"name"];
    object.type = [results stringForColumn:@"type"];
    object.notnull = [results boolForColumn:@"notnull"];
    object.dflt_value = [results stringForColumn:@"dflt_value"];
    object.pk = [results boolForColumn:@"pk"];
    
    return object;
}

@end
