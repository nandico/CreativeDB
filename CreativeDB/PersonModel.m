//
//  PersonModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonModel.h"
#import "FMDBDataAccess.h"
#import "EntryModel.h"

@implementation PersonModel

+ (NSString *) tableName
{
    return @"aa_person";
}

- (NSString *) tableName
{
    return [PersonModel tableName];
}

+ (NSString *) fields
{
    return @"id, country, name, portfolioURL, rankingGlobal, rankingCountry, scoreGlobal, scoreCountry ";
}

- (NSString *) fields
{
    return [PersonModel fields];
}

+ (PersonModel *) objectWithResults:(FMResultSet *)results
{
    PersonModel *object = [[PersonModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.country = [CountryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"country"]]];
    object.name = [results stringForColumn:@"name"];
    if([[results resultDictionary] objectForKey:@"portfolioURL"] != nil)
        object.portfolioURL = [[NSURL alloc] initWithString:[results stringForColumn:@"portfolioURL"]];
    
    object.rankingGlobal = [NSNumber numberWithLong:[results longForColumn:@"rankingGlobal"]];
    object.rankingCountry = [NSNumber numberWithLong:[results longForColumn:@"rankingCountry"]];
    object.scoreGlobal = [NSNumber numberWithLong:[results longForColumn:@"scoreGlobal"]];
    object.scoreCountry = [NSNumber numberWithLong:[results longForColumn:@"scoreCountry"]];
    
    return object;
}

+ (PersonModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    PersonModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self fields], [self tableName], [pk longValue] ] ];
    
    if( [results next] )
    {
        model = [PersonModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (PersonModel *) loadModelByStringValue:(NSString *) stringValue
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    PersonModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " name = '%@' ", [self fields], [self tableName], stringValue ] ];
    
    if( [results next] )
    {
        model = [PersonModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadAll
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    PersonModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " ORDER BY name ", [self fields], [self tableName] ] ];
    
    while( [results next] )
    {
        model = [PersonModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}

- (NSMutableArray *) entries
{
    return [EntryModel loadByPersonId:self.pk];
}

- (NSNumber *) next
{
    if( !_pk ) return nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    PersonModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[ NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " id > %ld "
                                                       " ORDER BY id " , [self fields], [self tableName], [_pk longValue] ] ];
    
    if( [results next] )
    {
        model = [PersonModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    
    return model.pk;
}

- (NSNumber *) previous
{
    if( !_pk ) return nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    PersonModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " id < %ld "
                                                       " ORDER BY id DESC ", [self fields], [self tableName], [_pk longValue] ] ];
    
    if( [results next] )
    {
        model = [PersonModel objectWithResults:results];
    }
    
    
    [results close];
    [db close];
    
    return model.pk;
}

+ (NSNumber *) first
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    PersonModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT "
                                             " %@ "
                                             " FROM %@ "
                                             " ORDER BY id ASC ", [self fields], [self tableName] ] ];
    if( [results next] )
    {
        model = [PersonModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return ( model.pk ) ? model.pk : nil;
}

+ (NSNumber *) last
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    PersonModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " ORDER BY id DESC ", [self fields], [self tableName] ] ];
    
    if( [results next] )
    {
        model = [PersonModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return ( model.pk ) ? model.pk : nil;
}

- (void) save
{
    if( self.pk )
    {
        [self update];
    }
    else
    {
        [self insert];
    }
}

- (void) deleteModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    NSString *sql = [NSString stringWithFormat:@" DELETE FROM %@ WHERE id = ? ", [self tableName]];
    
    [db executeUpdate:sql, self.pk];
    [db close];
    
}

- (void) insert
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    NSString *sql = [NSString stringWithFormat:@" INSERT INTO %@ "
                     " ( %@ ) "
                     " VALUES "
                     " ( null, ?, ?, ?, 0, 0, 0, 0 ) ", [self tableName], [self fields] ];
    
    [db executeUpdate:sql,
     self.country.pk,
     self.name,
     self.portfolioURL];
    
    [db close];
    
}

- (void) update
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    db.traceExecution = YES;
    
    [db open];
    
    if( self.country )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET country = %@ WHERE id = %@", [self tableName],
                           self.country.pk, self.pk ]];
    }
    if( self.name )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET name = '%@' WHERE id = %@", [self tableName],
                           self.name, self.pk ]];
    }
    if( self.portfolioURL )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET portfolioURL = '%@' WHERE id = %@", [self tableName],
                           self.portfolioURL, self.pk ]];
    }
    if( self.rankingGlobal )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET rankingGlobal = %@ WHERE id = %@", [self tableName],
                           self.rankingGlobal, self.pk ]];
    }
    if( self.rankingCountry )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET rankingCountry = %@ WHERE id = %@", [self tableName],
                           self.rankingCountry, self.pk ]];
    }
    if( self.scoreGlobal )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET scoreGlobal = %@ WHERE id = %@", [self tableName],
                           self.scoreGlobal, self.pk ]];
    }
    if( self.scoreCountry )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET scoreCountry = %@ WHERE id = %@", [self tableName],
                           self.scoreCountry, self.pk ]];
    }
    
    [db close];
    
}

+ (void) resetScore
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    NSString *sqlGlobal = [NSString stringWithFormat:@" UPDATE aa_person SET rankingGlobal = 0 "];
    [db executeUpdate:sqlGlobal];
    
    NSString *sqlCountry = [NSString stringWithFormat:@" UPDATE aa_person SET rankingCountry = 0 "];
    [db executeUpdate:sqlCountry];

    NSString *sqlGlobalScore = [NSString stringWithFormat:@" UPDATE aa_person SET scoreGlobal = 0 "];
    [db executeUpdate:sqlGlobalScore];
    
    NSString *sqlCountryScore = [NSString stringWithFormat:@" UPDATE aa_person SET scoreCountry = 0 "];
    [db executeUpdate:sqlCountryScore];

    
    [db close];
    
}


@end
