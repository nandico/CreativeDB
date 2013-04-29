//
//  BaseModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

@class BaseModel;

@protocol BaseModelProtocol

+ (NSString *) tableName;
+ (NSString *) fields;
+ (BaseModel *) objectWithResults:(FMResultSet *)results;
+ (BaseModel *) loadModel:(NSNumber *) pk;
+ (BaseModel *) loadModelByStringValue:(NSString *) stringValue;
+ (NSMutableArray *) loadAll;
 
@end

@interface BaseModel : NSObject <BaseModelProtocol>

@end
