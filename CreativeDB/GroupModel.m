//
//  GroupModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "GroupModel.h"
#import "FMDBDataAccess.h"

@implementation GroupModel

+ (GroupModel *) objectWithResults:(FMResultSet *)results
{
    GroupModel *object = [[GroupModel alloc] init];
    object.pk = [results longForColumn:@"id"];
    object.name = [results stringForColumn:@"name"];
    
    return object;
}

+ (GroupModel *) loadModel:(NSInteger) pk
{
    FMDBDataAccess *db = [FMDBDataAccess getInstance];
    return [db loadGroup:pk];
}

@end
