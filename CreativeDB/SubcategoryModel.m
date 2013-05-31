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

+ (NSString *) fields
{
    return @"id, name, category";
}

- (NSString *) fields
{
    return [SubcategoryModel fields];
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
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self fields], [self tableName], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [SubcategoryModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (SubcategoryModel *) loadModelByStringValue:(NSString *) stringValue
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    SubcategoryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " name = '%@' ", [self fields], [self tableName], stringValue] ];
    
    if( [results next] )
    {
        model = [SubcategoryModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadAll
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    SubcategoryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ ", [self fields], [self tableName] ] ];
    
    while( [results next] )
    {
        model = [SubcategoryModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}

+ (NSNumber *) first
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    SubcategoryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT "
                                             " %@ "
                                             " FROM %@ "
                                             " ORDER BY id ASC ", [self fields], [self tableName] ] ];
    if( [results next] )
    {
        model = [SubcategoryModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return ( model.pk ) ? model.pk : nil;
}

+ (NSNumber *) last
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    SubcategoryModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " ORDER BY id DESC ", [self fields], [self tableName] ] ];
    
    if( [results next] )
    {
        model = [SubcategoryModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return ( model.pk ) ? model.pk : nil;
}

- (void) save
{
    if( self.pk )
    {
        [self update];
    }
    else
    {
        [self insert];
    }
}

- (void) deleteModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    NSString *sql = [NSString stringWithFormat:@" DELETE FROM %@ WHERE id = ? ", [self tableName]];
    
    [db executeUpdate:sql, self.pk];
    [db close];
    
}

- (void) insert
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    NSString *sql = [NSString stringWithFormat:@" INSERT INTO %@ "
                     " ( %@ ) "
                     " VALUES "
                     " ( null, ? ) ", [self tableName], [self fields] ];
    
    [db executeUpdate:sql,
     self.name];
    
    [db close];
    
}

- (void) update
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    if( self.name )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET name = '%@' WHERE id = %@", [self tableName],
                           self.name, self.pk ]];
    }
    
    [db close];
    
}


@end
