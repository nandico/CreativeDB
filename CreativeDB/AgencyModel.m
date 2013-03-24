//
//  AgencyModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AgencyModel.h"
#import "GroupModel.h"

@implementation AgencyModel

+ (AgencyModel *) objectWithResults:(FMResultSet *)results
{
    AgencyModel *object = [[AgencyModel alloc] init];
    object.pk = [results longForColumn:@"id"];
    object.group = [GroupModel loadModel:[results longForColumn:@"agency_group"]];
    object.country = [CountryModel loadModel:[results longForColumn:@"country"]];
    object.name = [results stringForColumn:@"name"];

    return object;
}


@end
