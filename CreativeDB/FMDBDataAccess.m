//
//  FMDBDataAccess.m
//  Reader
//
//  Created by Fernando Aquino on 2/17/13.
//  Copyright (c) 2013 Huge. All rights reserved.
//

#import "FMDBDataAccess.h"
#import "TableModel.h"
#import "ColumnModel.h"

@implementation FMDBDataAccess

-(id)init
{
    self = [super init];
    if (self)
    {
        //self.channelUpdates = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (FMDBDataAccess *)getInstance
{
    static FMDBDataAccess *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FMDBDataAccess alloc] init];
    });
    return sharedInstance;
}

- (void)getSchema
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
    FMResultSet *results = [db getSchema];
    
    while([results next])
    {
        TableModel *table = [TableModel objectWithResults:results];
        table.columns = [self getTableSchema:table.name];
    }

    [results close];
    [db close];
}

- (NSMutableArray *) getTableSchema:(NSString *)tableName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
    FMResultSet *results = [db getTableSchema:tableName];
    
    while([results next])
    {
        ColumnModel *column = [ColumnModel objectWithResults:results];
        [items addObject:column];
    }
    
    [results close];
    [db close];
    
    return items;
    
}

- (ColumnModel *) getColumnSchema:(NSString *)tableName withColumnName:(NSString *) columnName;
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
    FMResultSet *results = [db getTableSchema:tableName];
    
    while([results next])
    {
        ColumnModel *column = [ColumnModel objectWithResults:results];
        
        if( [column.name isEqualToString:columnName] )
        {
            [results close];
            [db close];
            return column;
        }
    }
    
    [results close];
    [db close];
    
    return nil;
}



@end
