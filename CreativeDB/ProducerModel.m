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

+ (NSString *) tableName
{
    return @"aa_producer";
}

- (NSString *) tableName
{
    return [ProducerModel tableName];
}

+ (NSString *) fields
{
    return @"id, country, name, siteURL";
}

- (NSString *) fields
{
    return [ProducerModel fields];
}

+ (ProducerModel *) objectWithResults:(FMResultSet *)results
{
    ProducerModel *object = [[ProducerModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.country = [CountryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"country"]]];
    object.name = [results stringForColumn:@"name"];
    if([[results resultDictionary] objectForKey:@"siteURL"] != nil)
        object.siteURL = [[NSURL alloc] initWithString:[results stringForColumn:@"siteURL"]];
    
    return object;
}

+ (ProducerModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProducerModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self fields], [self tableName], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [ProducerModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

@end
