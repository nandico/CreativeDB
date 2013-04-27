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

+ (NSString *) tableName
{
    return @"aa_discipline";
}

- (NSString *) tableName
{
    return [DisciplineModel tableName];
}

+ (NSString *) fields
{
    return @"id, name";
}

- (NSString *) fields
{
    return [DisciplineModel fields];
}

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
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self fields], [self tableName], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [DisciplineModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


@end
