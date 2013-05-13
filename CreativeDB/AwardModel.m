//
//  AwardModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AwardModel.h"
#import "FMDBDataAccess.h"
#import "CreditModel.h"

@implementation AwardModel

static NSString *modelFilterName;
static NSNumber *modelFilterValue;

+ (NSString *) tableName
{
    return @"aa_award";
}

- (NSString *) tableName
{
    return [AwardModel tableName];
}

+ (NSString *) fields
{
    return @"id, metal, category, entry, festival, subcategory, year";
}

- (NSString *) fields
{
    return [AwardModel fields];
}

+ (AwardModel *) objectWithResults:(FMResultSet *)results
{
    AwardModel *object = [[AwardModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.metal = [MetalModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"metal"]]];
    object.category = [CategoryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"category"]]];
    object.entry = [EntryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"entry"]]];
    object.festival = [FestivalModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"festival"]]];
    object.subcategory = [SubcategoryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"subcategory"]]];
    object.year = [NSNumber numberWithLong:[results longForColumn:@"year"]];
    
    return object;
}

+ (AwardModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    AwardModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM aa_award "
                            " WHERE "
                            " id = %ld ", [self fields], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [AwardModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadByEntryId:(NSNumber *) entryPK
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    AwardModel *model;
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " entry = %ld ", [self fields], [self tableName], [entryPK integerValue] ] ];
    
    while( [results next] )
    {
        model = [AwardModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
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

- (NSNumber *) next
{
    if( !_pk ) return nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    AwardModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[ NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " id > %ld "
                                                       " AND %@ = %@ "
                                                       " ORDER BY id " , [self fields], [self tableName], [_pk integerValue], modelFilterName, modelFilterValue ] ];
    
    if( [results next] )
    {
        model = [AwardModel objectWithResults:results];
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
    
    AwardModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@  "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " id < %ld "
                                                       " AND %@ = %@ "
                                                       " ORDER BY id DESC ", [self fields], [self tableName], [_pk integerValue], modelFilterName, modelFilterValue ] ];
    
    if( [results next] )
    {
        model = [AwardModel objectWithResults:results];
    }
    
    
    [results close];
    [db close];
    
    return model.pk;
}

+ (NSNumber *) first
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    AwardModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    db.traceExecution = YES;
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT "
                                             " %@  "
                                             " FROM %@ "
                                             " WHERE %@ = %@ "
                                             " ORDER BY id ASC ", [self fields], [self tableName], modelFilterName, modelFilterValue ] ];
    
    if( [results next] )
    {
        model = [AwardModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return ( model.pk ) ? model.pk : nil;
}

+ (NSNumber *) last
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    AwardModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE %@ = %@ "
                                                       " ORDER BY id DESC ", [self fields], [self tableName], modelFilterName, modelFilterValue ] ];
    
    if( [results next] )
    {
        model = [AwardModel objectWithResults:results];
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
                     " ( null, %@, %@, %@, %@, %@, %@ ) ",[self tableName], [self fields],
                     self.metal.pk,
                     self.category.pk,
                     self.entry.pk,
                     self.festival.pk,
                     self.subcategory.pk,
                     self.year
                     ];

    [db executeUpdate:sql];
    
    [db close];
    
}

- (void) update
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    db.traceExecution = YES;
    
    if( self.metal )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET metal = %@ WHERE id = %@", [self tableName],
                           self.metal.pk, self.pk ] ];
    }
    if( self.category )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET category = %@ WHERE id = %@", [self tableName],
                           self.category.pk, self.pk ] ];
    }
    if( self.entry )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET entry = %@ WHERE id = %@", [self tableName],
                           self.entry.pk, self.pk ] ];
    }
    if( self.festival )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET festival = %@ WHERE id = %@", [self tableName],
                           self.festival.pk, self.pk ] ];
    }
    if( self.subcategory )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET subcategory = %@ WHERE id = %@", [self tableName],
                           self.subcategory.pk, self.pk ] ];
    }
    if( self.year )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET year = %@ WHERE id = %@", [self tableName],
                           self.year, self.pk ] ];
    }
    
    [db close];
    
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


@end
