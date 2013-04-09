//
//  RoleModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "RoleModel.h"
#import "FMDBDataAccess.h"

@implementation RoleModel

+ (RoleModel *) objectWithResults:(FMResultSet *)results
{
    RoleModel *object = [[RoleModel alloc] init];
    object.pk = [results longForColumn:@"id"];
    object.name = [results stringForColumn:@"name"];
    object.obs = [results stringForColumn:@"obs"];
    
    return object;
}

+ (RoleModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    RoleModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, name, obs "
                            " FROM aa_role "
                            " WHERE "
                            " id = %ld ", [pk integerValue] ];
    
    if( [results next] )
    {
        model = [RoleModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


@end
