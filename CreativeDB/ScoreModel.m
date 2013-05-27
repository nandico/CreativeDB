//
//  ScoreModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/27/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ScoreModel.h"
#import "FMDBDataAccess.h"

@implementation ScoreModel

static NSString *tableName;

+ (NSString *) tableName
{
    @synchronized( self )
    {
        return tableName;
    }
}

+ (void) setTableName: (NSString *) name
{
    @synchronized( self )
    {
        tableName = name;
    }
}

+ (NSString *) fields
{
    return @"id, origin, entry, festival, year, score";
}

- (NSString *) fields
{
    return [ScoreModel fields];
}

+ (ScoreModel *) objectWithResults:(FMResultSet *)results
{
    ScoreModel *object = [[ScoreModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.origin = [NSNumber numberWithLong:[results longForColumn:@"origin"]];
    object.entry = [NSNumber numberWithLong:[results longForColumn:@"entry"]];
    object.festival = [NSNumber numberWithLong:[results longForColumn:@"festival"]];
    object.year = [NSNumber numberWithLong:[results longForColumn:@"year"]];
    object.score = [NSNumber numberWithLong:[results longForColumn:@"score"]];
    
    return object;
}

+ (ScoreModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    ScoreModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                                                       " %@ "
                                                       " FROM %@ "
                                                       " WHERE "
                                                       " id = %ld ", [self fields], [self tableName], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [ScoreModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

+ (BaseModel *) loadModelByStringValue:(NSString *) stringValue
{
    return nil;
}

+ (NSMutableArray *) loadAll
{
    return nil;
}


@end
