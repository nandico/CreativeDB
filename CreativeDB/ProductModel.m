//
//  ProductModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProductModel.h"
#import "FMDBDataAccess.h"

@implementation ProductModel

static NSString *modelFilterName;
static NSNumber *modelFilterValue;

+ (NSString *) tableName
{
    return @"aa_product";
}

- (NSString *) tableName
{
    return [ProductModel tableName];
}

+ (NSString *) fields
{
    return @"id, client, name";
}

- (NSString *) fields
{
    return [ProductModel fields];
}

+ (NSString *) modelFilterName
{
    @synchronized( self )
    {
        return modelFilterName;
    }
}

+ (void) setModelFilterName:(NSString *) filterName
{
    @synchronized( self )
    {
        modelFilterName = filterName;
    }
}

+ (NSNumber *) modelFilterValue
{
    @synchronized( self )
    {
        return modelFilterValue;
    }
}

+ (void) setModelFilterValue:(NSNumber *) filterValue
{
    @synchronized( self )
    {
        modelFilterValue = filterValue;
    }
}

+ (ProductModel *) objectWithResults:(FMResultSet *)results
{
    ProductModel *object = [[ProductModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.client = [ClientModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"client"]]];
    object.name = [results stringForColumn:@"name"];
    
    return object;
}

+ (ProductModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProductModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self fields], [self tableName], [pk longValue] ] ];
    
    if( [results next] )
    {
        model = [ProductModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (ProductModel *) loadModelByStringValue:(NSString *) stringValue
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProductModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " name = '%@' ", [self fields], [self tableName], stringValue ] ];
    
    if( [results next] )
    {
        model = [ProductModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadByClientId:(NSNumber *) clientPK
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProductModel *model;
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " client = %ld ", [self fields], [self tableName], [clientPK longValue] ] ];
    
    while( [results next] )
    {
        model = [ProductModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}


+ (NSMutableArray *) loadAll
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProductModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ ", [self fields], [self tableName] ] ];
    
    while( [results next] )
    {
        model = [ProductModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}

- (NSNumber *) next
{
    if( !_pk ) return nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProductModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[ NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " id > %ld "
                                                       " AND %@ = %@ "
                                                       " ORDER BY id " , [self fields], [self tableName], [_pk longValue], modelFilterName, modelFilterValue ] ];
    
    if( [results next] )
    {
        model = [ProductModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    
    return model.pk;
}

- (NSNumber *) previous
{
    if( !_pk ) return nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProductModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " id < %ld "
                                                       " AND %@ = %@ "
                                                       " ORDER BY id DESC ", [self fields], [self tableName], [_pk longValue], modelFilterName, modelFilterValue ] ];
    
    if( [results next] )
    {
        model = [ProductModel objectWithResults:results];
    }
    
    
    [results close];
    [db close];
    
    return model.pk;
}

+ (NSNumber *) first
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProductModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
        
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT "
                                             " %@ "
                                             " FROM %@ "
                                             " WHERE %@ = %@ "
                                             " ORDER BY id ASC ", [self fields], [self tableName], modelFilterName, modelFilterValue ] ];
    if( [results next] )
    {
        model = [ProductModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return ( model.pk ) ? model.pk : nil;
}

+ (NSNumber *) last
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProductModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE %@ = %@ "
                                                       " ORDER BY id DESC ", [self fields], [self tableName], modelFilterName, modelFilterValue ] ];
    
    if( [results next] )
    {
        model = [ProductModel objectWithResults:results];
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
                     " ( null, ?, ? ) ", [self tableName], [self fields] ];
    
    [db executeUpdate:sql,
     self.client.pk,
     self.name];
    
    [db close];
    
}

- (void) update
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    if( self.client )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET client = %@ WHERE id = %@", [self tableName],
                           self.client.pk, self.pk ]];
    }
    if( self.name )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET name = '%@' WHERE id = %@", [self tableName],
                           self.name, self.pk ]];
    }
    
    [db close];
    
}

@end
