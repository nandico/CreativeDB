//
//  CountryModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CountryModel.h"
#import "FMDBDataAccess.h"

@implementation CountryModel

+ (CountryModel *) objectWithResults:(FMResultSet *)results
{
    CountryModel *object = [[CountryModel alloc] init];
    object.pk = [results longForColumn:@"id"];
    object.iso = [results stringForColumn:@"iso"];
    object.language = [results stringForColumn:@"language"];
    object.numcode = [results longForColumn:@"numcode"];
    object.printable_name = [results stringForColumn:@"printable_name"];
    object.iso3 = [results stringForColumn:@"iso3"];
    object.name = [results stringForColumn:@"name"];
    
    return object;
}

+ (CountryModel *) loadModel:(NSInteger) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CountryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, iso, language, numcode, printable_name, iso3, name "
                            " FROM aa_country "
                            " WHERE "
                            " id = %ld ", pk ];
    
    if( [results next] )
    {
        model = [CountryModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

@end
