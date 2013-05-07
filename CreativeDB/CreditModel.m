//
//  CreditModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CreditModel.h"
#import "FMDBDataAccess.h"

@implementation CreditModel

+ (NSString *) tableName
{
    return @"aa_credit";
}

- (NSString *) tableName
{
    return [CreditModel tableName];
}

+ (NSString *) fields
{
    return @"id, person, entry, role";
}

- (NSString *) fields
{
    return [CreditModel fields];
}


+ (CreditModel *) objectWithResults:(FMResultSet *)results
{
    CreditModel *object = [[CreditModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.person = [PersonModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"person"]]];
    object.entry = [EntryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"entry"]]];
    object.role = [RoleModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"role"]]];
    
    return object;
}

+ (CreditModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CreditModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];

    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " id = %ld ", [self fields], [self tableName], [pk integerValue] ] ];

    
    if( [results next] )
    {
        model = [CreditModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (NSMutableArray *) loadByEntryId:(NSNumber *) entryPK
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CreditModel *model;
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
        model = [CreditModel objectWithResults:results];
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
    
    CreditModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[ NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " id > %ld "
                                                       " ORDER BY id " , [self fields], [self tableName], [_pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [CreditModel objectWithResults:results];
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
    
    CreditModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@  "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " id < %ld "
                                                       " ORDER BY id DESC ", [self fields], [self tableName], [_pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [CreditModel objectWithResults:results];
    }
    
    
    [results close];
    [db close];
    
    return model.pk;
}

+ (NSNumber *) first
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CreditModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT "
                                             " %@  "
                                             " FROM %@ "
                                             " ORDER BY id ASC ", [self fields], [self tableName] ] ];
    
    if( [results next] )
    {
        model = [CreditModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return ( model.pk ) ? model.pk : nil;
}

+ (NSNumber *) last
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CreditModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " ORDER BY id DESC ", [self fields], [self tableName] ] ];
    
    if( [results next] )
    {
        model = [CreditModel objectWithResults:results];
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
                     " ( null, ?, ?, ? ) ", [self fields], [self tableName] ];
    
    [db executeUpdate:sql,
     self.person.pk,
     self.entry.pk,
     self.role.pk];
    
    [db close];
    
}

- (void) update
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    if( self.person )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET person = ? WHERE id = ?", [self tableName]],
         self.person.pk, self.pk ];
    }
    if( self.entry )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET entry = ? WHERE id = ?", [self tableName]],
         self.entry.pk, self.pk ];
    }
    if( self.role )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET role = ? WHERE id = ?", [self tableName]],
         self.role.pk, self.pk ];
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
