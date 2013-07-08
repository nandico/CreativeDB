//
//  GroupModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "GroupModel.h"
#import "FMDBDataAccess.h"
#import "ScoreModel.h"

@interface GroupModel()

@property (nonatomic, strong) NSNumber *countryPK;

@end

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
    return @"id, name, country";
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
    object.countryPK = [NSNumber numberWithLong:[results longForColumn:@"country"]];
    
    return object;
}

- (CountryModel *) country
{
    if( !_country )
    {
        _country = [CountryModel loadModel:_countryPK];
    }
    
    return _country;
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
                            " id = %ld ", [self fields], [self tableName], [pk longValue] ] ];
    
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
                            " FROM %@ "
                            " ORDER BY name", [self fields], [self tableName] ] ];
    
    while( [results next] )
    {
        model = [GroupModel objectWithResults:results];
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

+ (NSNumber *) modelActiveCount
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    NSNumber *count = @0;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[ NSString stringWithFormat:@"SELECT "
                                                       " COUNT( * ) total "
                                                       " FROM %@ "
                                                       " WHERE id IN ( "
                                                       "    SELECT DISTINCT( C.agency_group ) from aa_entry AS A "
                                                       "    INNER JOIN aa_award AS B on A.id = B.entry "
                                                       "    INNER JOIN aa_agency AS C ON A.agency = C.id "
                                                       " ) ", [self tableName]] ];
    
    while( [results next] )
    {
        count = [NSNumber numberWithLong:[results longForColumn:@"total"]];
    }
    
    [results close];
    [db close];
    
    return count;
}

- (NSMutableArray *) entries
{
    return [EntryModel loadByGroupId:self.pk];
}

+ (NSMutableArray *) loadFiltered
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    GroupModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE id IN ( "
                                                       "    SELECT DISTINCT( C.agency_group ) from aa_entry AS A "
                                                       "    INNER JOIN aa_award AS B on A.id = B.entry "
                                                       "    INNER JOIN aa_agency AS C ON A.agency = C.id "
                                                       " ) ", [self fields], [self tableName] ] ];
    
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
                                                       " name = \"%@\" ", [self fields], [self tableName], stringValue ] ];
    
    if( [results next] )
    {
        model = [GroupModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

- (NSNumber *) next
{
    if( !_pk ) return nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    GroupModel *model;
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
        model = [GroupModel objectWithResults:results];
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
    
    GroupModel *model;
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
        model = [GroupModel objectWithResults:results];
    }
    
    
    [results close];
    [db close];
    
    return model.pk;
}

+ (NSNumber *) first
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    GroupModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT "
                                             " %@ "
                                             " FROM %@ "
                                             " ORDER BY id ASC ", [self fields], [self tableName] ] ];
    if( [results next] )
    {
        model = [GroupModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return ( model.pk ) ? model.pk : nil;
}

+ (NSNumber *) last
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    GroupModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " ORDER BY id DESC ", [self fields], [self tableName] ] ];
    
    if( [results next] )
    {
        model = [GroupModel objectWithResults:results];
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
     self.name, self.country.pk];
    
    [db close];
    
}

- (void) update
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    if( self.name )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET name = '%@' WHERE id = %@", [self tableName],
                           self.name, self.pk ]];
    }
    if( self.country )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET country = %@ WHERE id = %@", [self tableName],
                           self.country.pk, self.pk ]];
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
                                             " FROM aa_group_score_year AS B "
                                             " WHERE B.score > A.score AND year = %@ "
                                             " ) AS Rank "
                                             " FROM aa_group_score_year AS A "
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
    
    db.traceExecution = YES;
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT A.*, ( "
                                             " SELECT COUNT( * ) "
                                             " FROM aa_group_score_year AS B "
                                             " INNER JOIN aa_group AS C ON B.origin = C.id WHERE C.country = %@ AND B.year = %@ AND B.score > A.score "
                                             " ) AS Rank "
                                             " FROM aa_group_score_year AS A "
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
    
    db.traceExecution = YES;
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " rankingGlobal "
                                                       " FROM aa_group_score_year "
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
                                                       " FROM aa_group_score_year "
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
