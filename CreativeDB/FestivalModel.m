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
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, name, siteURL, weight, obs, classify "
                            " FROM aa_festival "
                            " WHERE "
                            " id = %ld ", [pk integerValue] ];
    
    if( [results next] )
    {
        model = [FestivalModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

@end
