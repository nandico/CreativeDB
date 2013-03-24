//
//  ProducerModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProducerModel.h"
#import "FMDBDataAccess.h"

@implementation ProducerModel

+ (ProducerModel *) objectWithResults:(FMResultSet *)results
{
    ProducerModel *object = [[ProducerModel alloc] init];
    object.pk = [results longForColumn:@"id"];
    object.country = [CountryModel loadModel:[results longForColumn:@"country"]];    
    object.name = [results stringForColumn:@"name"];
    if([[results resultDictionary] objectForKey:@"siteURL"] != nil)
        object.siteURL = [[NSURL alloc] initWithString:[results stringForColumn:@"siteURL"]];
    
    return object;
}

+ (ProducerModel *) loadModel:(NSInteger) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProducerModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, country, name, siteURL "
                            " FROM aa_producer "
                            " WHERE "
                            " id = %ld ", pk ];
    
    if( [results next] )
    {
        model = [ProducerModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadByEntryId:(NSInteger) entryPK
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProducerModel *model;
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    //TODO: In progress.
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, country, name, siteURL "
                            " FROM aa_producer "
                            " WHERE "
                            " entry = %ld ", entryPK ];
    
    while( [results next] )
    {
        model = [ProducerModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}




@end
