//
//  CountryModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface CountryModel : BaseModel

@property (assign) NSInteger pk;
@property (strong) NSString *iso;
@property (strong) NSString *language;
@property (assign) NSInteger numcode;
@property (strong) NSString *printable_name;
@property (strong) NSString *iso3;
@property (strong) NSString *name;

+ (CountryModel *) objectWithResults:(FMResultSet *)results;
+ (CountryModel *) loadModel:(NSInteger) pk;

@end
