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

+ (CalendarTypeModel *) objectWithResults:(FMResultSet *)results
{
    CalendarTypeModel *object = [[CalendarTypeModel alloc] init];
    object.pk = [results longForColumn:@"id"];
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
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, name "
                            " FROM aa_calendar_type "
                            " WHERE "
                            " id = %ld ", [pk integerValue] ];
    
    if( [results next] )
    {
        model = [CalendarTypeModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


@end
