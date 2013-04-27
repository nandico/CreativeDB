//
//  CalendarTypeModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CalendarTypeModel.h"
#import "FMDBDataAccess.h"

@implementation CalendarTypeModel

+ (NSString *) tableName
{
    return @"aa_calendar_type";
}

- (NSString *) tableName
{
    return [CalendarTypeModel tableName];
}


+ (CalendarTypeModel *) objectWithResults:(FMResultSet *)results
{
    CalendarTypeModel *object = [[CalendarTypeModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.name = [results stringForColumn:@"name"];
    
    return object;
}

+ (CalendarTypeModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CalendarTypeModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " id, name "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self tableName], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [CalendarTypeModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


@end
