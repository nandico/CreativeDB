//
//  ProducerCreditModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProducerCreditModel.h"
#import "FMDBDataAccess.h"

@implementation ProducerCreditModel

static NSString *modelFilterName;
static NSNumber *modelFilterValue;

+ (NSString *) tableName
{
    return @"aa_entry_producer";
}

- (NSString *) tableName
{
    return [ProducerCreditModel tableName];
}

+ (NSString *) fields
{
    return @"id, entry, producer, discipline";
}

- (NSString *) fields
{
    return [ProducerCreditModel fields];
}

+ (ProducerCreditModel *) objectWithResults:(FMResultSet *)results
{
    ProducerCreditModel *object = [[ProducerCreditModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.entry = [EntryModel loadModel:[NSNumber numberWithInteger:[results longForColumn:@"entry"]]];
    object.producer = [ProducerModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"producer"]]];
    object.discipline = [DisciplineModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"discipline"]]];
   
    return object;
}

+ (ProducerCreditModel *) loadModel:(NSNumber *) pk
{    
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProducerCreditModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " id = %ld ", [self fields], [self tableName], [pk integerValue] ] ];
    
    
    if( [results next] )
    {
        model = [ProducerCreditModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadByEntryId:(NSNumber *) entryPK
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProducerCreditModel *model;
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
        model = [ProducerCreditModel objectWithResults:results];
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
    
    ProducerCreditModel *model;
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
        model = [ProducerCreditModel objectWithResults:results];
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
    
    ProducerCreditModel *model;
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
        model = [ProducerCreditModel objectWithResults:results];
    }
    
    
    [results close];
    [db close];
    
    return model.pk;
}

+ (NSNumber *) first
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProducerCreditModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
            
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT "
                                             " %@  "
                                             " FROM %@ "
                                             " WHERE %@ = %@ "
                                             " ORDER BY id ASC ", [self fields], [self tableName], modelFilterName, modelFilterValue ] ];
    
    if( [results next] )
    {
        model = [ProducerCreditModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return ( model.pk ) ? model.pk : nil;
}

+ (NSNumber *) last
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ProducerCreditModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE %@ = %@ "
                                                       " ORDER BY id DESC ", [self fields], [self tableName], modelFilterName, modelFilterValue ] ];
    
    if( [results next] )
    {
        model = [ProducerCreditModel objectWithResults:results];
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
    
    NSString *sql = [NSString stringWithFormat:@" INSERT INTO %@ "
                     " ( %@ ) "
                     " VALUES "
                     " ( null, %@, %@, %@ ) ",[self tableName], [self fields], self.entry.pk,
                     self.producer.pk,
                     self.discipline.pk ];
    
    [db executeUpdate:sql];
    
    [db close];
    
}

- (void) update
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    if( self.entry )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET entry = %@ WHERE id = %@", [self tableName],
                           self.entry.pk, self.pk ] ];
    }    
    if( self.producer )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET producer = %@ WHERE id = %@", [self tableName],
                           self.producer.pk, self.pk ] ];
    }
    if( self.discipline )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET discipline = %@ WHERE id = %@", [self tableName],
                           self.discipline.pk, self.pk ] ];
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
