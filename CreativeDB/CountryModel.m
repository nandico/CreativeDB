//
//  CountryModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CountryModel.h"
#import "FMDBDataAccess.h"

@implementation CountryModel

+ (NSString *) tableName
{
    return @"aa_country";
}

- (NSString *) tableName
{
    return [CountryModel tableName];
}

+ (NSString *) fields
{
    return @"id, iso, language, numcode, printable_name, iso3, name";
}

- (NSString *) fields
{
    return [CountryModel fields];
}

+ (CountryModel *) objectWithResults:(FMResultSet *)results
{
    CountryModel *object = [[CountryModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.iso = [results stringForColumn:@"iso"];
    object.language = [results stringForColumn:@"language"];
    object.numcode = [results longForColumn:@"numcode"];
    object.printable_name = [results stringForColumn:@"printable_name"];
    object.iso3 = [results stringForColumn:@"iso3"];
    object.name = [results stringForColumn:@"name"];
    
    return object;
}

+ (CountryModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CountryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self fields], [self tableName], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [CountryModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (CountryModel *) loadModelByStringValue:(NSString *) stringValue
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CountryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " name = '%@' ", [self fields], [self tableName], stringValue ] ];
    
    if( [results next] )
    {
        model = [CountryModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


+ (NSMutableArray *) loadAll
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CountryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ ", [self fields], [self tableName] ] ];
    
    while( [results next] )
    {
        model = [CountryModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}

+ (NSMutableArray *) loadFiltered
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CountryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " id IN ( "
                                                       "    SELECT DISTINCT( country ) "
                                                       "    FROM aa_agency_score "
                                                       " ) "
                                                       " OR id IN ( "
                                                       "    SELECT DISTINCT( country ) "
                                                       "    FROM aa_client_score "
                                                       " ) "
                                                       " OR id IN ( "
                                                       "    SELECT DISTINCT( country ) "
                                                       "    FROM aa_country_score "
                                                       " ) "
                                                       " OR id IN ( "
                                                       "    SELECT DISTINCT( country ) "
                                                       "    FROM aa_group_score "
                                                       " ) "
                                                       " OR id IN ( "
                                                       "    SELECT DISTINCT( country ) "
                                                       "    FROM aa_person_score "
                                                       " ) "
                                                       " OR id IN ( "
                                                       "    SELECT DISTINCT( country ) "
                                                       "    FROM aa_producer_score "
                                                       " ) "
                                                       " OR id IN ( "
                                                       "    SELECT DISTINCT( country ) "
                                                       "    FROM aa_product_score "
                                                       " ) "
                                                       , [self fields], [self tableName] ] ];
    
    while( [results next] )
    {
        model = [CountryModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
    
}

- (NSString *) description
{
    return self.name;
}

@end
