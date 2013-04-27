//
//  CategoryModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CategoryModel.h"
#import "FMDBDataAccess.h"

@implementation CategoryModel

+ (NSString *) tableName
{
    return @"aa_category";
}

- (NSString *) tableName
{
    return [CategoryModel tableName];
}


+ (CategoryModel *) objectWithResults:(FMResultSet *)results
{
    CategoryModel *object = [[CategoryModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.name = [results stringForColumn:@"name"];
    
    return object;
}

+ (CategoryModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CategoryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " id, name "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self tableName], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [CategoryModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


@end
