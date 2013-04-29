//
//  BaseModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSString *) tableName
{
    return nil;
}

+ (NSString *) fields
{
    return nil;
}

+ (BaseModel *) objectWithResults:(FMResultSet *)results
{
    return nil;
}

+ (BaseModel *) loadModel:(NSNumber *) pk
{
    return nil;
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
