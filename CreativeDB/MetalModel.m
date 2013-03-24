//
//  MetalModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "MetalModel.h"
#import "FMDBDataAccess.h"

@implementation MetalModel

+ (MetalModel *) objectWithResults:(FMResultSet *)results
{
    MetalModel *object = [[MetalModel alloc] init];
    object.pk = [results longForColumn:@"id"];
    object.name = [results stringForColumn:@"name"];
    
    return object;
}

+ (MetalModel *) loadModel:(NSInteger) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    MetalModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, name "
                            " FROM aa_metal "
                            " WHERE "
                            " id = %ld ", pk ];
    
    if( [results next] )
    {
        model = [MetalModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


@end
