//
//  EntryModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryModel.h"
#import "FMDBDataAccess.h"
#import "CreditModel.h"
#import "ProducerCreditModel.h"
#import "AnnotationModel.h"
#import "AwardModel.h"
#import "ScoreModel.h"

@interface EntryModel()

@property (strong) NSNumber *agencyPK;
@property (strong) NSNumber *clientPK;
@property (strong) NSNumber *countryPK;
@property (strong) NSNumber *productPK;

@end

@implementation EntryModel

+ (NSString *) tableName
{
    return @"aa_entry";
}

- (NSString *) tableName
{
    return [EntryModel tableName];
}

+ (NSString *) fields
{
    return @"id, agency, client, country, product, accessURL, caseURL, blurb, name, year";
}

- (NSString *) fields
{
    return [EntryModel fields];
}

+ (EntryModel *) objectWithResults:(FMResultSet *)results
{
    EntryModel *object = [[EntryModel alloc] init];

    object.pk = [NSNumber numberWithInt:[results intForColumn:@"id"]];
    object.agencyPK = [NSNumber numberWithLong:[results longForColumn:@"agency"]];
    object.clientPK = [NSNumber numberWithLong:[results longForColumn:@"client"]];
    object.countryPK = [NSNumber numberWithLong:[results longForColumn:@"country"]];
    object.productPK = [NSNumber numberWithLong:[results longForColumn:@"product"]];
    if([[results resultDictionary] objectForKey:@"accessURL"])
        object.accessURL = [[NSURL alloc] initWithString:[results stringForColumn:@"accessURL"]];
    if([[results resultDictionary] objectForKey:@"caseURL"])
        object.caseURL = [[NSURL alloc] initWithString:[results stringForColumn:@"caseURL"]];
    
    object.blurb = [results stringForColumn:@"blurb"];
    object.name = [results stringForColumn:@"name"];
    object.year = [NSNumber numberWithLong:[results longForColumn:@"year"]];
    
    return object;
}

- (AgencyModel *) agency
{
    if( !_agency )
    {
        _agency = [AgencyModel loadModel:_agencyPK];
    }
        
    return _agency;
}

- (ClientModel *) client
{
    if( !_client )
    {
        _client = [ClientModel loadModel:_clientPK];
    }
    
    return _client;
}

- (CountryModel *) country
{
    if( !_country )
    {
        _country = [CountryModel loadModel:_countryPK];
    }
    
    return _country;
}

- (ProductModel *) product
{
    if( !_product )
    {
        _product = [ProductModel loadModel:_productPK];
    }
    
    return _product;
}

+ (EntryModel *) loadModel:(NSNumber *)pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    EntryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self fields], [self tableName], [pk longValue] ] ];
    
    if( [results next] )
    {
        model = [EntryModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (EntryModel *) loadModelByStringValue:(NSString *) stringValue
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    EntryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " name = \"%@\" ", [self fields], [self tableName], stringValue] ];
    
    if( [results next] )
    {
        model = [EntryModel objectWithResults:results];
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
    
    EntryModel *model;
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
        model = [EntryModel objectWithResults:results];
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
    
    EntryModel *model;
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
        model = [EntryModel objectWithResults:results];
    }
    
    
    [results close];
    [db close];
    
    return model.pk;
}

+ (NSNumber *) first
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    EntryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
        
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " ORDER BY id ASC ", [self fields], [self tableName] ] ];
    if( [results next] )
    {
        model = [EntryModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return ( model.pk ) ? model.pk : nil;
}

+ (NSNumber *) last
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    EntryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " ORDER BY id DESC ", [self fields], [self tableName] ] ];
    
    if( [results next] )
    {
        model = [EntryModel objectWithResults:results];
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
                        " ( null, ?, ?, ?, ?, ?, ?, ?, ?, ? ) ", [self tableName], [self fields] ];
    
    [db executeUpdate:sql,
     self.agency.pk,
     self.client.pk,
     self.country.pk,
     self.product.pk,
     self.accessURL,
     self.caseURL,
     self.blurb,
     self.name,
     self.year];
    
    [db close];
    
}

- (void) update
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    if( self.agency )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET agency = ? WHERE id = ?", [self tableName]],
         self.agency.pk, self.pk ];
    }
    if( self.client )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET client = ? WHERE id = ?", [self tableName]],
         self.client.pk, self.pk ];
    }
    if( self.country )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET country = ? WHERE id = ?", [self tableName]],
         self.country.pk, self.pk ];
    }
    if( self.product )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET product = ? WHERE id = ?", [self tableName]],
         self.product.pk, self.pk ];
    }
    if( self.accessURL )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET accessURL = ? WHERE id = ?", [self tableName]],
         self.accessURL, self.pk ];
    }
    if( self.caseURL )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET caseURL = ? WHERE id = ?", [self tableName]],
         self.caseURL, self.pk ];
    }
    if( self.blurb )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET blurb = ? WHERE id = ?", [self tableName]],
         self.blurb, self.pk ];
    }
    if( self.name )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET name = ? WHERE id = ?", [self tableName]],
         self.name, self.pk ];
    }
    if( self.year )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET year = ? WHERE id = ?", [self tableName]],
         self.year, self.pk ];
    }
    
    [db close];
    
}

- (NSMutableArray *) credits
{
    return [CreditModel loadByEntryId:self.pk];
}


- (NSMutableArray *) producers
{
    return [ProducerCreditModel loadByEntryId:self.pk];
}

- (NSMutableArray *) annotations
{
    return [AnnotationModel loadByEntryId:self.pk];
}

- (NSMutableArray *) awards
{
    return [AwardModel loadByEntryId:self.pk];
}

+ (NSMutableArray *) loadAll
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    EntryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[ NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ ", [self fields], [self tableName]] ];
    
    while( [results next] )
    {
        model = [EntryModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}

+ (NSMutableArray *) loadByPersonId:(NSNumber *)personPK
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    EntryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[ NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE id IN ( "
                                                            " SELECT DISTINCT entry FROM aa_credit WHERE person = %@ "
                                                       " ) ", [self fields], [self tableName], personPK] ];
    
    while( [results next] )
    {
        model = [EntryModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}

+ (NSMutableArray *) loadByAgencyId:(NSNumber *)agencyPK
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    EntryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[ NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE agency = %@", [self fields], [self tableName], agencyPK] ];
    
    while( [results next] )
    {
        model = [EntryModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
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
                                             " FROM aa_entry_score_year AS B "
                                             " WHERE B.score > A.score AND year = %@ "
                                             " ) AS Rank "
                                             " FROM aa_entry_score_year AS A "
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
                                             " FROM aa_entry_score_year AS B "
                                             " INNER JOIN aa_agency AS C ON B.origin = C.id WHERE C.country = %@ AND B.year = %@ AND B.score > A.score "
                                             " ) AS Rank "
                                             " FROM aa_entry_score_year AS A "
                                             " WHERE A.origin = %@ " , self.country.pk, year, self.pk ] ];
    if( [results next] )
    {
        ranking = [NSNumber numberWithLong:[results longForColumn:@"Rank"]];
        
        NSLog( @"Ranking: %@", ranking );
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
                                                       " FROM aa_entry_score_year "
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
                                                       " FROM aa_entry_score_year "
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
