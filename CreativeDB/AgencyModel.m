//
//  AgencyModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AgencyModel.h"
#import "GroupModel.h"
#import "FMDBDataAccess.h"

@implementation AgencyModel

+ (AgencyModel *) objectWithResults:(FMResultSet *)results
{
    AgencyModel *object = [[AgencyModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.group = [GroupModel loadModel:[results longForColumn:@"agency_group"]];
    object.country = [CountryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"country"]]];
    object.name = [results stringForColumn:@"name"];

    return object;
}

+ (AgencyModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    AgencyModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, agency_group, country, name "
                            " FROM aa_agency "
                            " WHERE "
                            " id = %ld ", [pk integerValue] ];
    
    if( [results next] )
    {
        model = [AgencyModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (AgencyModel *) loadModelByStringValue:(NSString *) stringValue
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    AgencyModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, agency_group, country, name "
                            " FROM aa_agency "
                            " WHERE "
                            " name = %@ ", stringValue ];
    
    if( [results next] )
    {
        model = [AgencyModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadAll
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    AgencyModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, agency_group, country, name "
                            " FROM aa_agency " ];
    
    while( [results next] )
    {
        model = [AgencyModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}


@end
