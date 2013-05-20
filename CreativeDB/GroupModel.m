//
//  GroupModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "GroupModel.h"
#import "FMDBDataAccess.h"

@implementation GroupModel

+ (NSString *) tableName
{
    return @"aa_group";
}

- (NSString *) tableName
{
    return [GroupModel tableName];
}

+ (NSString *) fields
{
    return @"id, name";
}

- (NSString *) fields
{
    return [GroupModel fields];
}

+ (GroupModel *) objectWithResults:(FMResultSet *)results
{
    GroupModel *object = [[GroupModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.name = [results stringForColumn:@"name"];
    
    return object;
}

+ (GroupModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    GroupModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self fields], [self tableName], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [GroupModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadAll
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    GroupModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ ", [self fields], [self tableName] ] ];
    
    while( [results next] )
    {
        model = [GroupModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}

+ (GroupModel *) loadModelByStringValue:(NSString *) stringValue
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    GroupModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " name = '%@' ", [self fields], [self tableName], stringValue ] ];
    
    if( [results next] )
    {
        model = [GroupModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


@end
