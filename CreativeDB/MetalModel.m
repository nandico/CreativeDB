//
//  MetalModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "MetalModel.h"
#import "FMDBDataAccess.h"

@implementation MetalModel

+ (NSString *) tableName
{
    return @"aa_metal";
}

- (NSString *) tableName
{
    return [MetalModel tableName];
}

+ (NSString *) fields
{
    return @"id, name, weight";
}

- (NSString *) fields
{
    return [MetalModel fields];
}

+ (MetalModel *) objectWithResults:(FMResultSet *)results
{
    MetalModel *object = [[MetalModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.name = [results stringForColumn:@"name"];
    object.weight = [NSNumber numberWithLong:[results longForColumn:@"weight"]];
    
    return object;
}

+ (MetalModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    MetalModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self fields], [self tableName], [pk longValue] ] ];
    
    if( [results next] )
    {
        model = [MetalModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (MetalModel *) loadModelByStringValue:(NSString *) stringValue
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    MetalModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " name = \"%@\" ", [self fields], [self tableName], stringValue] ];
    
    if( [results next] )
    {
        model = [MetalModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadAll
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    MetalModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ ", [self fields], [self tableName] ] ];
    
    while( [results next] )
    {
        model = [MetalModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}

@end
