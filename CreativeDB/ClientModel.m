//
//  ClientModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ClientModel.h"
#import "FMDBDataAccess.h"
#import "ScoreModel.h"

@implementation ClientModel

+ (NSString *) tableName
{
    return @"aa_client";
}

- (NSString *) tableName
{
    return [ClientModel tableName];
}

+ (NSString *) fields
{
    return @"id, country, name";
}

- (NSString *) fields
{
    return [ClientModel fields];
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
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self fields], [self tableName], [pk longValue] ] ];
    
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
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " name = \"%@\" ", [self fields], [self tableName], stringValue ] ];
    
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
                            " %@ "
                            " FROM %@ "
                            " ORDER BY name ", [self fields], [self tableName] ] ];
    
    while( [results next] )
    {
        model = [ClientModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}

+ (NSNumber *) modelCount
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    NSNumber *count = @0;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[ NSString stringWithFormat:@"SELECT "
                                                       " COUNT( * ) total "
                                                       " FROM %@ ", [self tableName]] ];
    
    while( [results next] )
    {
        count = [NSNumber numberWithLong:[results longForColumn:@"total"]];
    }
    
    [results close];
    [db close];
    
    return count;
}


- (NSNumber *) next
{
    if( !_pk ) return nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ClientModel *model;
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
        model = [ClientModel objectWithResults:results];
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
    
    ClientModel *model;
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
        model = [ClientModel objectWithResults:results];
    }
    
    
    [results close];
    [db close];
    
    return model.pk;
}

+ (NSNumber *) first
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ClientModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT "
                                             " %@ "
                                             " FROM %@ "
                                             " ORDER BY id ASC ", [self fields], [self tableName] ] ];
    if( [results next] )
    {
        model = [ClientModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return ( model.pk ) ? model.pk : nil;
}

+ (NSNumber *) last
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ClientModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " ORDER BY id DESC ", [self fields], [self tableName] ] ];
    
    if( [results next] )
    {
        model = [ClientModel objectWithResults:results];
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
                     " ( null, ?, ? ) ", [self tableName], [self fields] ];
    
    [db executeUpdate:sql,
     self.country.pk,
     self.name];
    
    [db close];
    
}

- (void) update
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
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
    
    [db close];
    
}

- (NSInteger) calculateRankGlobal:(NSNumber *) year
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    NSNumber *ranking;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT A.*, ( "
                                             " SELECT COUNT( * ) "
                                             " FROM aa_client_score_year AS B "
                                             " WHERE B.score > A.score AND year = %@ "
                                             " ) AS Rank "
                                             " FROM aa_client_score_year AS A "
                                             " WHERE A.origin = %@ and year = %@ ", year, self.pk, year ] ];
    if( [results next] )
    {
        ranking = [NSNumber numberWithLong:[results longForColumn:@"Rank"]];
    }
    
    [results close];
    [db close];
    
    return ( ranking ) ? [ranking integerValue] : 0;
}

- (NSInteger) calculateRankCountry:(NSNumber *) year
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    NSNumber *ranking;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT A.*, ( "
                                             " SELECT COUNT( * ) "
                                             " FROM aa_client_score_year AS B "
                                             " INNER JOIN aa_agency AS C ON B.origin = C.id WHERE C.country = %@ AND B.year = %@ AND B.score > A.score "
                                             " ) AS Rank "
                                             " FROM aa_client_score_year AS A "
                                             " WHERE A.origin = %@ " , self.country.pk, year, self.pk ] ];
    if( [results next] )
    {
        ranking = [NSNumber numberWithLong:[results longForColumn:@"Rank"]];
    }
    
    [results close];
    [db close];
    
    return ( ranking ) ? [ranking integerValue] : 0;
}

- (NSNumber *) rankingGlobal
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    NSNumber *ranking = @0;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " rankingGlobal "
                                                       " FROM aa_client_score_year "
                                                       " WHERE "
                                                       " origin = %@ "
                                                       " AND year = %@", self.pk, [ScoreModel rankYear] ] ];
    
    if( [results next] )
    {
        ranking = [NSNumber numberWithLong:[results longForColumn:@"rankingGlobal"]];
    }
    
    [results close];
    [db close];
    
    return ranking;
    
}

- (NSNumber *) rankingCountry
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    NSNumber *ranking = @0;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " rankingCountry "
                                                       " FROM aa_client_score_year "
                                                       " WHERE "
                                                       " origin = %@ "
                                                       " AND year = %@", self.pk, [ScoreModel rankYear] ] ];
    
    if( [results next] )
    {
        ranking = [NSNumber numberWithLong:[results longForColumn:@"rankingCountry"]];
    }
    
    [results close];
    [db close];
    
    return ranking;
}



@end
