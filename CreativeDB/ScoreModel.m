//
//  ScoreModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/27/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ScoreModel.h"
#import "FMDBDataAccess.h"

@interface ScoreModel()

@property (strong) NSNumber *agencyPK;
@property (strong) NSNumber *clientPK;
@property (strong) NSNumber *countryPK;
@property (strong) NSNumber *groupPK;
@property (strong) NSNumber *personPK;
@property (strong) NSNumber *producerPK;
@property (strong) NSNumber *productPK;
@property (strong) NSNumber *entryPK;
@property (strong) NSNumber *festivalPK;

@end

@implementation ScoreModel

static NSString *tableName;
static NSNumber *actualRankYear;


+ (NSString *) tableName
{
    @synchronized( self )
    {
        return tableName;
    }
}

- (NSString *) tableName
{
    return ScoreModel.tableName;
}

+ (void) setTableName: (NSString *) name
{
    @synchronized( self )
    {
        tableName = name;
    }
}

+ (NSString *) fields
{
    return @"id, origin, country, entry, festival, year, score";
}

- (NSString *) fields
{
    return [ScoreModel fields];
}

+ (ScoreModel *) objectWithResults:(FMResultSet *)results
{
    ScoreModel *object = [[ScoreModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.origin = [NSNumber numberWithLong:[results longForColumn:@"origin"]];

    object.countryPK = [NSNumber numberWithLong:[results longForColumn:@"country"]];

    if( [[ScoreModel tableName] isEqualToString:@"aa_person_score"] )
        object.personPK = object.origin;
    
    if( [[ScoreModel tableName] isEqualToString:@"aa_agency_score"] )
        object.agencyPK = object.origin;
    
    if( [[ScoreModel tableName] isEqualToString:@"aa_client_score"] )
        object.clientPK = object.origin;
    
    if( [[ScoreModel tableName] isEqualToString:@"aa_country_score"] )
        object.countryPK = object.origin;

    if( [[ScoreModel tableName] isEqualToString:@"aa_group_score"] )
        object.groupPK = object.origin;

    if( [[ScoreModel tableName] isEqualToString:@"aa_producer_score"] )
        object.producerPK = object.origin;
    
    if( [[ScoreModel tableName] isEqualToString:@"aa_product_score"] )
        object.productPK = object.origin;
     
    object.entryPK = [NSNumber numberWithLong:[results longForColumn:@"entry"]];
    
    object.festivalPK = [NSNumber numberWithLong:[results longForColumn:@"festival"]];
    
    object.year = [NSNumber numberWithLong:[results longForColumn:@"year"]];
    object.score = [NSNumber numberWithLong:[results longForColumn:@"score"]];
    
    return object;
}

+ (void) updateScoreForTablename:(NSString *) tableName
                       withAward:(AwardModel *) award
                       forOrigin:(NSNumber *) origin
                       withScore:(NSNumber *) score
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    NSString *sqlDelete = [NSString stringWithFormat:@" DELETE FROM %@ "
                                                    " WHERE origin = %@ "
                                                    " AND YEAR = %@", tableName, origin, award.year ];
    
    [db executeUpdate:sqlDelete];

    NSString *sqlInsert = [NSString stringWithFormat:@" INSERT INTO %@ "
                           " ( origin, year, score ) "
                           " VALUES "
                           " ( %@, %@, %@ ) ", tableName, origin, award.year, score ];
    
    [db executeUpdate:sqlInsert];
    
    [db close];
}

+ (NSInteger) calculateScoreWithTablename:(NSString *) tableName forOrigin:(NSNumber *) origin andYear:(NSNumber *) year
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    NSNumber *score;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT "
                                             " SUM ( score ) AS score  "
                                             " FROM %@ "
                                             " WHERE origin = %@ AND year = %@ ", tableName, origin, year ] ];
    if( [results next] )
    {
        score = [NSNumber numberWithLong:[results longForColumn:@"score"]];
    }
        
    [results close];
    [db close];
    
    return ( score ) ? [score integerValue] : 0;
}

- (CountryModel *) country
{
    if( !_country )
    {
        _country = [CountryModel loadModel:_countryPK];
    }
    
    return _country;
}

- (PersonModel *) person
{
    if( !_person )
    {
        _person = [PersonModel loadModel:_personPK];
    }
    
    return _person;
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

- (GroupModel *) group
{
    if( !_group )
    {
        _group = [GroupModel loadModel:_groupPK];
    }
    
    return _group;
}

- (ProducerModel *) producer
{
    if( !_producer )
    {
        _producer = [ProducerModel loadModel:_producerPK];
    }
    
    return _producer;
}

- (ProductModel *) product
{
    if( !_product )
    {
        _product = [ProductModel loadModel:_productPK];
    }
    
    return _product;
}

- (EntryModel *) entry
{
    if( !_entry )
    {
        _entry = [EntryModel loadModel:_entryPK];
    }
    
    return _entry;
}

+ (ScoreModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ScoreModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                        " FROM %@ "
                                                       " WHERE "
                                                       " id = %ld ", [self fields], [self tableName], [pk longValue] ] ];
    
    if( [results next] )
    {
        model = [ScoreModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (BaseModel *) loadModelByStringValue:(NSString *) stringValue
{
    return nil;
}

+ (NSMutableArray *) loadAll
{
    return nil;
}

+ (NSMutableArray *) loadRankingByTableName: (NSString *) tableName
{
    return [ScoreModel loadRankingByTableName:tableName andFilters:nil];

}

+ (NSMutableArray *) loadRankingByTableName: (NSString *) tableName andFilters:(NSMutableDictionary *)filters
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ScoreModel *model;
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    NSMutableString *sqlFilter = [NSMutableString stringWithString:@""];
    
    if( filters )
    {
        for( NSString *filterName in filters )
        {
            if( [filterName isEqualToString:@"country"] )
            {
                CountryModel *country = [CountryModel loadModelByStringValue:[filters objectForKey:filterName]];
            
                if( sqlFilter.length == 0 )
                {
                    [sqlFilter appendString:[NSString stringWithFormat:@" WHERE A.%@ = \"%@\"", filterName, country.pk ]];
                }
                else
                {
                    [sqlFilter appendString:[NSString stringWithFormat:@" AND A.%@ = \"%@\"", filterName, country.pk ]];
                }
            }
            else if( [filterName isEqualToString:@"group"] )
            {
                GroupModel *group = [GroupModel loadModelByStringValue:[filters objectForKey:filterName]];
                
                if( sqlFilter.length == 0 )
                {
                    [sqlFilter appendString:[NSString stringWithFormat:@" WHERE %@ = %@", @"C.agency_group", group.pk ]];
                }
                else
                {
                    [sqlFilter appendString:[NSString stringWithFormat:@" AND %@ = %@", @"C.agency_group", group.pk ]];
                }
            }
        }
    }
        
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " A.id, A.origin, A.country, A.entry, A.festival, A.year, SUM( score ) score "
                                                       " FROM %@ AS A "
                                                       " INNER JOIN aa_entry AS B ON A.entry = B.id "
                                                       " INNER JOIN aa_agency AS C ON B.agency = C.id "
                                                       " %@ "
                                                       " GROUP BY origin "
                                                       " ORDER BY score DESC ", tableName, sqlFilter ] ];
    NSInteger count = 0;
    
    while( [results next] )
    {
        model = [ScoreModel objectWithResults:results];
        [collection addObject:model];
        
        count ++;
        
        // TODO: Implement a infinity scrolling / pagination
        if( count > 999 ) break;
    }
    
    [results close];
    [db close];
    
    return collection;
    
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

+ (void) resetScore:(NSString *) tableName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    NSString *sql = [NSString stringWithFormat:@" DELETE FROM %@ ", tableName];
    
    [db executeUpdate:sql];
    [db close];
    
}

- (BOOL) checkForDuplicity
{    
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    NSString *sql = [NSString stringWithFormat:@" SELECT * FROM %@ "
                          " WHERE origin = %@ "
                          " AND country = %@ "
                          " AND entry = %@ "
                          " AND festival = %@ "
                          " AND year = %@ ", [self tableName],
                          self.origin,
                          self.country.pk,
                          self.entry.pk,
                          self.festival.pk,
                          self.year];
    
    FMResultSet *results = [db executeQuery:sql];
    
    if( [results next] )
    {
        [db close];
        return YES;
    }
    [db close];
    return NO;
}

- (void) insert
{
    if( [self checkForDuplicity] )
    {
        return;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
        
    NSString *sql = [NSString stringWithFormat:@" INSERT INTO %@ "
                     " ( %@ ) "
                     " VALUES "
                     " ( null, ?, ?, ?, ?, ?, ? ) ", [self tableName], [self fields] ];
    
    [db executeUpdate:sql,
     self.origin,
     self.country.pk,
     self.entry.pk,
     self.festival.pk,
     self.year,
     self.score];
    
    [db close];
    
}

- (void) update
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    if( self.origin )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET origin = %@ WHERE id = %@", [self tableName],
                           self.origin, self.pk ]];
    }
    if( self.country )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET country = %@ WHERE id = %@", [self tableName],
                           self.country.pk, self.pk ]];
    }
    if( self.entry )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET origin = %@ WHERE id = %@", [self tableName],
                           self.entry.pk, self.pk ]];
    }
    if( self.festival )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET origin = %@ WHERE id = %@", [self tableName],
                           self.festival.pk, self.pk ]];
    }
    if( self.year )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET origin = %@ WHERE id = %@", [self tableName],
                           self.year, self.pk ]];
    }
    if( self.score )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET origin = %@ WHERE id = %@", [self tableName],
                           self.score, self.pk ]];
    }

    [db close];
    
}

+ (void) processRanking:(NSNumber *) year
{
    NSMutableArray *persons = [PersonModel loadAll];
    
    for( PersonModel *person in persons )
    {
        NSNumber *rankingGlobal = [NSNumber numberWithInteger:[person calculateRankGlobal:year] + 1];
        NSNumber *rankingCountry = [NSNumber numberWithInteger:[person calculateRankCountry:year] + 1];
        
        [self updateRankingGlobalForTablename:@"aa_person_score_year" andGlobal:rankingGlobal andCountry:rankingCountry forOrigin:person.pk andYear:year];
    }
    
    NSMutableArray *agencies = [AgencyModel loadAll];
    
    for( AgencyModel *agency in agencies )
    {
        NSNumber *rankingGlobal = [NSNumber numberWithInteger:[agency calculateRankGlobal:year] + 1];
        NSNumber *rankingCountry = [NSNumber numberWithInteger:[agency calculateRankCountry:year] + 1];
        
        [self updateRankingGlobalForTablename:@"aa_agency_score_year" andGlobal:rankingGlobal andCountry:rankingCountry forOrigin:agency.pk andYear:year];
        
    }
    
    NSMutableArray *entries = [EntryModel loadAll];
    
    for( EntryModel *entry in entries )
    {
        NSNumber *rankingGlobal = [NSNumber numberWithInteger:[entry calculateRankGlobal:year] + 1];
        NSNumber *rankingCountry = [NSNumber numberWithInteger:[entry calculateRankCountry:year] + 1];
        
        [self updateRankingGlobalForTablename:@"aa_entry_score_year" andGlobal:rankingGlobal andCountry:rankingCountry forOrigin:entry.pk andYear:year];
        
    }
    
    NSMutableArray *countries = [CountryModel loadAll];
 
    for( CountryModel *country in countries )
    {
        NSNumber *rankingGlobal = [NSNumber numberWithInteger:[country calculateRankGlobal:year] + 1];
        NSNumber *rankingCountry = [NSNumber numberWithInteger:[country calculateRankCountry:year] + 1];
        
        [self updateRankingGlobalForTablename:@"aa_country_score_year" andGlobal:rankingGlobal andCountry:rankingCountry forOrigin:country.pk andYear:year];
        
    }

    NSMutableArray *clients = [ClientModel loadAll];
    
    for( ClientModel *client in clients )
    {
        NSNumber *rankingGlobal = [NSNumber numberWithInteger:[client calculateRankGlobal:year] + 1];
        NSNumber *rankingCountry = [NSNumber numberWithInteger:[client calculateRankCountry:year] + 1];
        
        [self updateRankingGlobalForTablename:@"aa_client_score_year" andGlobal:rankingGlobal andCountry:rankingCountry forOrigin:client.pk andYear:year];
        
    }

    
}

+ (void) updateRankingGlobalForTablename:(NSString *) tableName
                               andGlobal:(NSNumber *) rankingGlobal
                              andCountry:(NSNumber *) rankingCountry
                               forOrigin:(NSNumber *) origin
                                 andYear:(NSNumber *) year
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    NSString *sqlGlobal = [NSString stringWithFormat:@" UPDATE %@ "
                           " SET rankingGlobal = %@ "
                           " WHERE year = %@ "
                           " AND origin = %@ ", tableName, rankingGlobal, year, origin];
    
    [db executeUpdate:sqlGlobal];
    
    NSString *sqlCountry = [NSString stringWithFormat:@" UPDATE %@ "
                            " SET rankingCountry = %@ "
                            " WHERE year = %@ "
                            " AND origin = %@ ", tableName, rankingCountry, year, origin];
    
    [db executeUpdate:sqlCountry];
    
    
    [db close];
    
    
}

+ (NSNumber *) rankYear
{
    @synchronized( self )
    {
        return actualRankYear;
    }
}

+ (void) setRankYear:(NSNumber *)rankYear
{
    @synchronized( self )
    {
        actualRankYear = rankYear;
    }
}



@end
