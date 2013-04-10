//
//  CreditModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CreditModel.h"
#import "FMDBDataAccess.h"

@implementation CreditModel

+ (CreditModel *) objectWithResults:(FMResultSet *)results
{
    CreditModel *object = [[CreditModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"rowid"]];
    object.person = [PersonModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"person"]]];
    object.entry = [EntryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"entry"]]];
    object.role = [RoleModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"role"]]];
    
    return object;
}

+ (CreditModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CreditModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " rowid, person, entry, role "
                            " FROM aa_credit "
                            " WHERE "
                            " id = %ld ", [pk integerValue] ];
    
    if( [results next] )
    {
        model = [CreditModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadByEntryId:(NSNumber *) entryPK
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CreditModel *model;
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " rowid, person, entry, role "
                            " FROM aa_credit "
                            " WHERE "
                            " entry = %ld ", [entryPK integerValue] ];
    
    while( [results next] )
    {
        model = [CreditModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}

@end
