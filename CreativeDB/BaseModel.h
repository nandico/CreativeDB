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

+ (BaseModel *) objectWithResults:(FMResultSet *)results;

@end

@interface BaseModel : NSObject <BaseModelProtocol>

@end
