//
//  ClientModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ClientModel.h"
#import "FMDBDataAccess.h"

@implementation ClientModel

+ (ClientModel *) objectWithResults:(FMResultSet *)results
{
    ClientModel *object = [[ClientModel alloc] init];
    object.pk = [results longForColumn:@"id"];
    object.country = [CountryModel loadModel:[results longForColumn:@"country"]];
    object.name = [results stringForColumn:@"name"];
    
    return object;
}

+ (ClientModel *) loadModel:(NSInteger) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ClientModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, country, name "
                            " FROM aa_client "
                            " WHERE "
                            " id = %ld ", pk ];
    
    if( [results next] )
    {
        model = [ClientModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

@end
