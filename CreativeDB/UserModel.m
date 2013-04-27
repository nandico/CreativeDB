//
//  UserModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "UserModel.h"
#import "FMDBDataAccess.h"

@implementation UserModel

+ (NSString *) tableName
{
    return @"aa_user";
}

- (NSString *) tableName
{
    return [UserModel tableName];
}

+ (NSString *) fields
{
    return @"id, fb_id, tw_id, name, email";
}

- (NSString *) fields
{
    return [UserModel fields];
}

+ (UserModel *) objectWithResults:(FMResultSet *)results
{
    UserModel *object = [[UserModel alloc] init];
    object.pk = [NSNumber numberWithLong:[results longForColumn:@"id"]];
    object.fb_id = [results stringForColumn:@"fb_id"];
    object.tw_id = [results stringForColumn:@"tw_id"];
    object.name = [results stringForColumn:@"name"];
    object.email = [results stringForColumn:@"email"];
    
    return object;
}

+ (UserModel *) loadModel:(NSNumber *) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    UserModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT "
                            " %@ "
                            " FROM %@ "
                            " WHERE "
                            " id = %ld ", [self fields], [self tableName], [pk integerValue] ] ];
    
    if( [results next] )
    {
        model = [UserModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}


@end
