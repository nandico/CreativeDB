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
    return @"id, country, name, portfolioURL, rankingGlobal, rankingCountry, score ";
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
    object.score = [NSNumber numberWithLong:[results longForColumn:@"score"]];
    
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
                     " ( null, ?, ?, ?, 0, 0, 0 ) ", [self tableName], [self fields] ];
    
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
    
//    db.traceExecution = YES;
    
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
    if( self.score )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET score = %@ WHERE id = %@", [self tableName],
                           self.score, self.pk ]];
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

    NSString *sqlScore = [NSString stringWithFormat:@" UPDATE aa_person SET score = 0 "];
    [db executeUpdate:sqlScore];
    
    
    [db close];
    
}

- (NSInteger) calculateScore
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    NSNumber *score;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT "
                                             " SUM ( score ) AS score  "
                                             " FROM aa_person_score "
                                             " WHERE origin = %@ ", self.pk ] ];
    if( [results next] )
    {
        score = [NSNumber numberWithLong:[results longForColumn:@"score"]];
    }
    
    [results close];
    [db close];
    
    return ( score ) ? [score integerValue] : 0;
}

- (NSInteger) calculateRankGlobal
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    NSNumber *ranking;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT A.*, ( "
                                             " SELECT COUNT( * ) "
                                             " FROM aa_person AS B "
                                             " WHERE B.score > A.score "
                                             " ) AS Rank "
                                             " FROM aa_person AS A "
                                             " WHERE id = %@", self.pk ] ];
    if( [results next] )
    {
        ranking = [NSNumber numberWithLong:[results longForColumn:@"Rank"]];
    }
    
    [results close];
    [db close];
    
    return ( ranking ) ? [ranking integerValue] : 0;
}

- (NSInteger) calculateRankCountry
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    NSNumber *ranking;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    db.traceExecution = YES;
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT A.*, ( "
                                             " SELECT COUNT( * ) "
                                             " FROM aa_person AS B "
                                             " WHERE B.country = %@ AND B.score > A.score "
                                             " ) AS Rank "
                                             " FROM aa_person AS A "
                                             " WHERE id = %@" , self.country.pk, self.pk ] ];
    if( [results next] )
    {
        ranking = [NSNumber numberWithLong:[results longForColumn:@"Rank"]];
    
        NSLog( @"Ranking: %@", ranking );
    }
    
    [results close];
    [db close];
    
    return ( ranking ) ? [ranking integerValue] : 0;
}

+ (void) processRanking
{
    NSMutableArray *persons = [PersonModel loadAll];
    
    /*
     SELECT A.*, (
     SELECT COUNT( * )
     FROM aa_person AS B
     WHERE B.score > A.score
     ) AS Rank
     FROM aa_person AS A
     WHERE id = 44
    */
    
    for( PersonModel *person in persons )
    {
        person.rankingGlobal = [NSNumber numberWithInteger:[person calculateRankGlobal] + 1];
        person.rankingCountry = [NSNumber numberWithInteger:[person calculateRankCountry] + 1];
        [person save];
    }
}

@end
