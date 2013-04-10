//
//  ProducerModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"
#import "CountryModel.h"

@interface ProducerModel : BaseModel

@property (assign) NSNumber *pk;
@property (strong) CountryModel *country;
@property (strong) NSString *name;
@property (strong) NSURL *siteURL;

+ (ProducerModel *) objectWithResults:(FMResultSet *)results;
+ (ProducerModel *) loadModel:(NSNumber *) pk;


@end
