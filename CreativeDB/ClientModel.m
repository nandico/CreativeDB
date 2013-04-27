//
//  ClientModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ClientModel.h"
#import "FMDBDataAccess.h"

@implementation ClientModel

+ (NSString *) tableName
{
    return @"aa_client";
}

- (NSString *) tableName
{
    return [ClientModel tableName];
}

+ (ClientModel *) objectWithResults:(FMResultSet *)results
{
    ClientModel *object = [[ClientModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.country = [CountryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"country"]]];
    object.name = [results stringForColumn:@"name"];
    
    return object;
}

+ (ClientModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ClientModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " id, country, name "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self tableName], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [ClientModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (ClientModel *) loadModelByStringValue:(NSString *) stringValue
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ClientModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " id, country, name "
                            " FROM %@ "
                            " WHERE "
                            " name = '%@' ", [self tableName], stringValue ] ];
    
    if( [results next] )
    {
        model = [ClientModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadAll
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ClientModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " id, country, name "
                            " FROM %@ ", [self tableName] ] ];
    
    while( [results next] )
    {
        model = [ClientModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}


@end
