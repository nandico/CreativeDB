//
//  ProductModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProductModel.h"
#import "FMDBDataAccess.h"

@implementation ProductModel

+ (ProductModel *) objectWithResults:(FMResultSet *)results
{
    ProductModel *object = [[ProductModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.client = [ClientModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"client"]]];
    object.name = [results stringForColumn:@"name"];
    
    return object;
}

+ (ProductModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProductModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, client, name "
                            " FROM aa_product "
                            " WHERE "
                            " id = %ld ", [pk integerValue] ];
    
    if( [results next] )
    {
        model = [ProductModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (ProductModel *) loadModelByStringValue:(NSString *) stringValue
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProductModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, client, name "
                            " FROM aa_product "
                            " WHERE "
                            " name = %@ ", stringValue ];
    
    if( [results next] )
    {
        model = [ProductModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


+ (NSMutableArray *) loadAll
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProductModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, client, name "
                            " FROM aa_product " ];
    
    while( [results next] )
    {
        model = [ProductModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}


@end
