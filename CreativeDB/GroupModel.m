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

+ (GroupModel *) objectWithResults:(FMResultSet *)results
{
    GroupModel *object = [[GroupModel alloc] init];
    object.pk = [results longForColumn:@"id"];
    object.name = [results stringForColumn:@"name"];
    
    return object;
}

+ (GroupModel *) loadModel:(NSInteger) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    GroupModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, name "
                            " FROM aa_group "
                            " WHERE "
                            " id = %ld ", pk ];
    
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
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, name "
                            " FROM aa_group " ];
    
    while( [results next] )
    {
        model = [GroupModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}


@end
