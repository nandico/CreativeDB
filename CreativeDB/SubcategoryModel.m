//
//  SubcategoryModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "SubcategoryModel.h"
#import "FMDBDataAccess.h"

@implementation SubcategoryModel

+ (NSString *) tableName
{
    return @"aa_subcategory";
}

- (NSString *) tableName
{
    return [SubcategoryModel tableName];
}


+ (SubcategoryModel *) objectWithResults:(FMResultSet *)results
{
    SubcategoryModel *object = [[SubcategoryModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.name = [results stringForColumn:@"name"];
    object.category = [CategoryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"category"]]];
    
    return object;
}

+ (SubcategoryModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    SubcategoryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " id, name, category "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self tableName], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [SubcategoryModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


@end
