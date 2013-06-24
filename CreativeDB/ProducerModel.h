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

@property (strong) NSNumber *pk;
@property (strong) CountryModel *country;
@property (strong) NSString *name;
@property (strong) NSURL *siteURL;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (ProducerModel *) objectWithResults:(FMResultSet *)results;
+ (ProducerModel *) loadModel:(NSNumber *) pk;
+ (ProducerModel *) loadModelByStringValue:(NSString *) stringValue;
+ (NSMutableArray *) loadAll;
+ (NSNumber *) modelCount;

- (NSNumber *) next;
- (NSNumber *) previous;
+ (NSNumber *) first;
+ (NSNumber *) last;

- (void) save;
- (void) deleteModel;

@end
