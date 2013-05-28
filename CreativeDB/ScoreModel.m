//
//  ScoreModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/27/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ScoreModel.h"
#import "FMDBDataAccess.h"

@implementation ScoreModel

static NSString *tableName;

+ (NSString *) tableName
{
    @synchronized( self )
    {
        return tableName;
    }
}

- (NSString *) tableName
{
    return ScoreModel.tableName;
}

+ (void) setTableName: (NSString *) name
{
    @synchronized( self )
    {
        tableName = name;
    }
}

+ (NSString *) fields
{
    return @"id, origin, entry, festival, year, score";
}

- (NSString *) fields
{
    return [ScoreModel fields];
}

+ (ScoreModel *) objectWithResults:(FMResultSet *)results
{
    ScoreModel *object = [[ScoreModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.origin = [NSNumber numberWithLong:[results longForColumn:@"origin"]];
    object.entry = [NSNumber numberWithLong:[results longForColumn:@"entry"]];
    object.festival = [NSNumber numberWithLong:[results longForColumn:@"festival"]];
    object.year = [NSNumber numberWithLong:[results longForColumn:@"year"]];
    object.score = [NSNumber numberWithLong:[results longForColumn:@"score"]];
    
    return object;
}

+ (ScoreModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ScoreModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                        " FROM %@ "
                                                       " WHERE "
                                                       " id = %ld ", [self fields], [self tableName], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [ScoreModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (BaseModel *) loadModelByStringValue:(NSString *) stringValue
{
    return nil;
}

+ (NSMutableArray *) loadAll
{
    return nil;
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
    
    db.traceExecution = YES;
    
    NSString *sql = [NSString stringWithFormat:@" INSERT INTO %@ "
                     " ( %@ ) "
                     " VALUES "
                     " ( null, ?, ?, ?, ?, ? ) ", [self tableName], [self fields] ];
    
    [db executeUpdate:sql,
     self.origin,
     self.entry,
     self.festival,
     self.year,
     self.score];
    
    [db close];
    
}

- (void) update
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    if( self.origin )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET origin = %@ WHERE id = %@", [self tableName],
                           self.origin, self.pk ]];
    }
    if( self.entry )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET origin = %@ WHERE id = %@", [self tableName],
                           self.entry, self.pk ]];
    }
    if( self.festival )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET origin = %@ WHERE id = %@", [self tableName],
                           self.festival, self.pk ]];
    }
    if( self.year )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET origin = %@ WHERE id = %@", [self tableName],
                           self.year, self.pk ]];
    }
    if( self.score )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET origin = %@ WHERE id = %@", [self tableName],
                           self.score, self.pk ]];
    }

    [db close];
    
}



@end
