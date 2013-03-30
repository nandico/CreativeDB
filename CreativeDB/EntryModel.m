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
    object.pk = [results longForColumn:@"id"];
    object.agency = [AgencyModel loadModel:[NSNumber numberWithInteger:[results longForColumn:@"agency"]]];
    object.client = [ClientModel loadModel:[results longForColumn:@"client"]];
    object.product = [ProductModel loadModel:[results longForColumn:@"product"]];
    if([[results resultDictionary] objectForKey:@"accessURL"] != nil)
        object.accessURL = [[NSURL alloc] initWithString:[results stringForColumn:@"accessURL"]];
    if([[results resultDictionary] objectForKey:@"caseURL"] != nil)
        object.caseURL = [[NSURL alloc] initWithString:[results stringForColumn:@"caseURL"]];
    object.blurb = [results stringForColumn:@"blurb"];
    object.name = [results stringForColumn:@"name"];
    object.year = [results longForColumn:@"year"];
    
    return object;
}

+ (EntryModel *) loadModel:(NSInteger) pk
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
                            " id = %ld ", pk ];
    
    if( [results next] )
    {
        model = [EntryModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
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
