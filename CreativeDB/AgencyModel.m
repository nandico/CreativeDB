//
//  AgencyModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AgencyModel.h"
#import "GroupModel.h"
#import "FMDBDataAccess.h"

@implementation AgencyModel

+ (AgencyModel *) objectWithResults:(FMResultSet *)results
{
    AgencyModel *object = [[AgencyModel alloc] init];
    object.pk = [results longForColumn:@"id"];
    object.group = [GroupModel loadModel:[results longForColumn:@"agency_group"]];
    object.country = [CountryModel loadModel:[results longForColumn:@"country"]];
    object.name = [results stringForColumn:@"name"];

    return object;
}

+ (AgencyModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    AgencyModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, agency_group, country, name "
                            " FROM aa_agency "
                            " WHERE "
                            " id = %ld ", [pk integerValue] ];
    
    if( [results next] )
    {
        model = [AgencyModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


@end
