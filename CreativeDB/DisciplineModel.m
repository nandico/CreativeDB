//
//  DisciplineModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "DisciplineModel.h"
#import "FMDBDataAccess.h"

@implementation DisciplineModel

+ (DisciplineModel *) objectWithResults:(FMResultSet *)results
{
    DisciplineModel *object = [[DisciplineModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.name = [results stringForColumn:@"name"];
    
    return object;
}

+ (DisciplineModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    DisciplineModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, name "
                            " FROM aa_discipline "
                            " WHERE "
                            " id = %ld ", [pk integerValue] ];
    
    if( [results next] )
    {
        model = [DisciplineModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


@end
