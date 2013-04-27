//
//  RoleModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "RoleModel.h"
#import "FMDBDataAccess.h"

@implementation RoleModel

+ (NSString *) tableName
{
    return @"aa_role";
}

- (NSString *) tableName
{
    return [RoleModel tableName];
}

+ (NSString *) fields
{
    return @"id, name, obs";
}

- (NSString *) fields
{
    return [RoleModel fields];
}

+ (RoleModel *) objectWithResults:(FMResultSet *)results
{
    RoleModel *object = [[RoleModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.name = [results stringForColumn:@"name"];
    object.obs = [results stringForColumn:@"obs"];
    
    return object;
}

+ (RoleModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    RoleModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, name, obs "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self fields], [pk integerValue] ];
    
    if( [results next] )
    {
        model = [RoleModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (RoleModel *) loadModelByStringValue:(NSString *) stringValue
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    RoleModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " name = '%@' ", [self fields], [self tableName], stringValue] ];
    
    if( [results next] )
    {
        model = [RoleModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadAll
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    RoleModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ ", [self fields], [self tableName] ] ];
    
    while( [results next] )
    {
        model = [RoleModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}


@end
