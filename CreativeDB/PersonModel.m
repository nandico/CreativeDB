//
//  PersonModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonModel.h"
#import "FMDBDataAccess.h"

@implementation PersonModel

+ (PersonModel *) objectWithResults:(FMResultSet *)results
{
    PersonModel *object = [[PersonModel alloc] init];
    object.pk = [results longForColumn:@"id"];
    object.country = [CountryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"country"]]];
    object.name = [results stringForColumn:@"name"];
    if([[results resultDictionary] objectForKey:@"portfolioURL"] != nil)
        object.portfolioURL = [[NSURL alloc] initWithString:[results stringForColumn:@"portfolioURL"]];
    
    return object;
}

+ (PersonModel *) loadModel:(NSInteger) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    PersonModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, country, name, portfolioURL "
                            " FROM aa_person "
                            " WHERE "
                            " id = %ld ", pk ];
    
    if( [results next] )
    {
        model = [PersonModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


@end
