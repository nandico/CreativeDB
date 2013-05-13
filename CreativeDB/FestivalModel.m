//
//  FestivalModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "FestivalModel.h"
#import "FMDBDataAccess.h"

@implementation FestivalModel

+ (NSString *) tableName
{
    return @"aa_festival";
}

- (NSString *) tableName
{
    return [FestivalModel tableName];
}

+ (NSString *) fields
{
    return @"id, name, siteURL, weight, obs, classify";
}

- (NSString *) fields
{
    return [FestivalModel fields];
}

+ (FestivalModel *) objectWithResults:(FMResultSet *)results
{
    FestivalModel *object = [[FestivalModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.name = [results stringForColumn:@"name"];
    if([[results resultDictionary] objectForKey:@"siteURL"] != nil)
        object.siteURL = [[NSURL alloc] initWithString:[results stringForColumn:@"siteURL"]];
    object.weight = [results longForColumn:@"weight"];
    object.obs = [results stringForColumn:@"obs"];
    object.classify = [results longForColumn:@"classify"];
    
    return object;
}

+ (FestivalModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FestivalModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self fields], [self tableName], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [FestivalModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadAll
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FestivalModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ ", [self fields], [self tableName] ] ];
    
    while( [results next] )
    {
        model = [FestivalModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}


@end
