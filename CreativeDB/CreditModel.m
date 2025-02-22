//
//  CreditModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CreditModel.h"
#import "FMDBDataAccess.h"

@interface CreditModel()

@property (strong) NSNumber *entryPK;
@property (strong) NSNumber *rolePK;
@property (strong) NSNumber *producerPK;

@end

@implementation CreditModel

static NSString *modelFilterName;
static NSNumber *modelFilterValue;

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
    return @"id, person, entry, role, producer";
}

- (NSString *) fields
{
    return [CreditModel fields];
}


+ (CreditModel *) objectWithResults:(FMResultSet *)results
{
    CreditModel *object = [[CreditModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    
    object.personPK = [NSNumber numberWithLong:[results longForColumn:@"person"]];
    object.entryPK = [NSNumber numberWithLong:[results longForColumn:@"entry"]];
    object.rolePK = [NSNumber numberWithLong:[results longForColumn:@"role"]];
    object.producerPK = [NSNumber numberWithLong:[results longForColumn:@"producer"]];
    
    return object;
}

- (PersonModel *) person
{
    if( !_person )
    {
        _person = [PersonModel loadModel:_personPK];
    }
    
    return _person;
}

- (EntryModel *) entry
{
    if( !_entry )
    {
        _entry = [EntryModel loadModel:_entryPK];
    }
    
    return _entry;
}

- (RoleModel *) role
{
    if( !_role )
    {
        _role = [RoleModel loadModel:_rolePK];
    }
    
    return _role;
}

- (ProducerModel *) producer
{
    if( !_producer )
    {
        if( _producerPK )
        {
            _producer = [ProducerModel loadModel:_producerPK];
        }
        else
        {
            _producer = nil;
        }
    }
    
    return _producer;
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
                                                       " id = %ld ", [self fields], [self tableName], [pk longValue] ] ];

    
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
                            " entry = %ld "
                            " ORDER BY person ", [self fields], [self tableName], [entryPK longValue] ] ];
    
    while( [results next] )
    {
        model = [CreditModel objectWithResults:results];
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
    
    CreditModel *model;
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
                                                       " AND %@ = %@ "
                                                       " ORDER BY id DESC ", [self fields], [self tableName], [_pk longValue], modelFilterName, modelFilterValue ] ];
    
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
                                             " WHERE %@ = %@ "
                                             " ORDER BY id ASC ", [self fields], [self tableName], modelFilterName, modelFilterValue ] ];
    
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
                                                       " WHERE %@ = %@ "
                                                       " ORDER BY id DESC ", [self fields], [self tableName], modelFilterName, modelFilterValue ] ];
    
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
                     " ( null, %@, %@, %@, %@ ) ",[self tableName], [self fields], self.person.pk,
                     self.entry.pk,
                     self.role.pk,
                     ( self.producer.pk ) ? [self.producer.pk stringValue] : @"null" ];
    
    [db executeUpdate:sql];
    
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
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET person = %@ WHERE id = %@", [self tableName],
         self.person.pk, self.pk ] ];
    }
    if( self.entry )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET entry = %@ WHERE id = %@", [self tableName],
         self.entry.pk, self.pk ] ];
    }
    if( self.role )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET role = %@ WHERE id = %@", [self tableName],
         self.role.pk, self.pk ] ];
    }
    if( self.producer )
    {
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET producer = %@ WHERE id = %@", [self tableName],
                           self.producer.pk, self.pk ] ];
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
