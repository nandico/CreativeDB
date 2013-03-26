//
//  ProducerCreditModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProducerCreditModel.h"
#import "FMDBDataAccess.h"

@implementation ProducerCreditModel

+ (ProducerCreditModel *) objectWithResults:(FMResultSet *)results
{
    ProducerCreditModel *object = [[ProducerCreditModel alloc] init];
    object.entry = [EntryModel loadModel:[results longForColumn:@"entry"]];
    object.producer = [ProducerModel loadModel:[results longForColumn:@"producer"]];
    object.discipline = [DisciplineModel loadModel:[results longForColumn:@"discipline"]];
   
    return object;
}

+ (NSMutableArray *) loadByEntryId:(NSInteger) entryPK
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProducerCreditModel *model;
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " entry, producer, discipline "
                            " FROM aa_entry_producer "
                            " WHERE "
                            " entry = %ld ", entryPK ];
        
    while( [results next] )
    {
        model = [ProducerCreditModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}


@end
