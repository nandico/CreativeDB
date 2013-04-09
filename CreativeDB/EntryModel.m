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

+ (EntryModel *) objectWithResults:(FMResultSet *)results
{
    EntryModel *object = [[EntryModel alloc] init];

    object.pk = [NSNumber numberWithInt:[results intForColumn:@"id"]];
    object.agency = [AgencyModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"agency"]]];
    object.client = [ClientModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"client"]]];
    object.country = [CountryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"country"]]];
    object.product = [ProductModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"product"]]];
    if([[results resultDictionary] objectForKey:@"accessURL"] != nil)
        object.accessURL = [[NSURL alloc] initWithString:[results stringForColumn:@"accessURL"]];
    if([[results resultDictionary] objectForKey:@"caseURL"] != nil)
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
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, agency, client, country, product, accessURL, caseURL, blurb, name, year "
                            " FROM aa_entry "
                            " WHERE "
                            " id = %ld ", [pk integerValue] ];
    
    if( [results next] )
    {
        model = [EntryModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

- (void) save
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    if( self.agency )
    {
        [db executeUpdate:@"UPDATE aa_entry SET agency = ? WHERE id = ?",
         self.agency.pk, self.pk ];
    }
    if( self.country )
    {
        [db executeUpdate:@"UPDATE aa_entry SET country = ? WHERE id = ?",
         self.country.pk, self.pk ];
    }
    if( self.product )
    {
        [db executeUpdate:@"UPDATE aa_entry SET product = ? WHERE id = ?",
         self.product.pk, self.pk ];
    }
    if( self.accessURL )
    {
        [db executeUpdate:@"UPDATE aa_entry SET accessURL = ? WHERE id = ?",
         self.accessURL, self.pk ];
    }
    if( self.caseURL )
    {
        [db executeUpdate:@"UPDATE aa_entry SET caseURL = ? WHERE id = ?",
         self.caseURL, self.pk ];
    }
    if( self.blurb )
    {
        [db executeUpdate:@"UPDATE aa_entry SET blurb = ? WHERE id = ?",
         self.blurb, self.pk ];
    }
    if( self.name )
    {
        [db executeUpdate:@"UPDATE aa_entry SET name = ? WHERE id = ?",
         self.name, self.pk ];
    }
    if( self.year )
    {
        [db executeUpdate:@"UPDATE aa_entry SET year = ? WHERE id = ?",
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


@end
