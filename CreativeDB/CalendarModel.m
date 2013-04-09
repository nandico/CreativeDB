//
//  CalendarModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CalendarModel.h"
#import "FestivalModel.h"
#import "FMDBDataAccess.h"

@implementation CalendarModel

+ (CalendarModel *) objectWithResults:(FMResultSet *)results
{
    CalendarModel *object = [[CalendarModel alloc] init];
    object.pk = [results longForColumn:@"id"];
    object.festival = [FestivalModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"festival"]]];
    object.type = [CalendarTypeModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"type"]]];
    object.category = [CategoryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"category"]]];
    object.date = [results dateForColumn:@"date"];
    object.year = [results longForColumn:@"year"];
    
    return object;
}

+ (CalendarModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    CalendarModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, festival, type, category, date, year "
                            " FROM aa_calendar "
                            " WHERE "
                            " id = %ld ", [pk integerValue] ];
    
    if( [results next] )
    {
        model = [CalendarModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

@end
