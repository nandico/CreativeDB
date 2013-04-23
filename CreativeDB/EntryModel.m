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

@implementation EntryModel

+ (NSString *) tableName
{
    return @"aa_entry";
}

- (NSString *) tableName
{
    return [EntryModel tableName];
}

+ (EntryModel *) objectWithResults:(FMResultSet *)results
{
    EntryModel *object = [[EntryModel alloc] init];

    object.pk = [NSNumber numberWithInt:[results intForColumn:@"id"]];
    object.agency = [AgencyModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"agency"]]];
    object.client = [ClientModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"client"]]];
    object.country = [CountryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"country"]]];
    object.product = [ProductModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"product"]]];
    if([[results resultDictionary] objectForKey:@"accessURL"])
        object.accessURL = [[NSURL alloc] initWithString:[results stringForColumn:@"accessURL"]];
    if([[results resultDictionary] objectForKey:@"caseURL"])
        object.caseURL = [[NSURL alloc] initWithString:[results stringForColumn:@"caseURL"]];
    
    object.blurb = [results stringForColumn:@"blurb"];
    object.name = [results stringForColumn:@"name"];
    object.year = [NSNumber numberWithLong:[results longForColumn:@"year"]];
    
    return object;
}

+ (EntryModel *) loadModel:(NSNumber *)pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    EntryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " id, agency, client, country, product, accessURL, caseURL, blurb, name, year "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self tableName], [pk integerValue] ] ];
    
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
                                                       " id, agency, client, country, product, accessURL, caseURL, blurb, name, year "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " name = '%@' ", [self tableName], stringValue] ];
    
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
                            " id, agency, client, country, product, accessURL, caseURL, blurb, name, year "
                            " FROM %@ "
                            " WHERE "
                            " id > %ld "
                            " ORDER BY id " , [self tableName], [_pk integerValue] ] ];
    
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
                            " id, agency, client, country, product, accessURL, caseURL, blurb, name, year "
                            " FROM %@ "
                            " WHERE "
                            " id < %ld "
                            " ORDER BY id DESC ", [self tableName], [_pk integerValue] ] ];
    
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
                            " id, agency, client, country, product, accessURL, caseURL, blurb, name, year "
                            " FROM %@ "
                            " ORDER BY id ASC ", [self tableName] ] ];    
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
                            " id, agency, client, country, product, accessURL, caseURL, blurb, name, year "
                            " FROM %@ "
                            " ORDER BY id DESC ", [self tableName] ] ];
    
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
                        " ( agency, client, country, product, accessURL, caseURL, blurb, name, year ) "
                        " VALUES "
                        " ( ?, ?, ?, ?, ?, ?, ?, ?, ? ) ", [self tableName] ];
    
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

+ (NSMutableArray *) loadAll
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    EntryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[ NSString stringWithFormat:@"SELECT "
                                                       " id, agency, client, country, product, accessURL, caseURL, blurb, name, year "
                                                       " FROM %@ ", [self tableName]] ];
    
    while( [results next] )
    {
        model = [EntryModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}


@end
