//
//  ProducerCreditModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"
#import "EntryModel.h"
#import "ProducerModel.h"
#import "DisciplineModel.h"

@interface ProducerCreditModel : BaseModel

@property (strong) NSNumber *pk;
@property (strong) EntryModel *entry;
@property (strong) ProducerModel *producer;
@property (strong) DisciplineModel *discipline;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (ProducerCreditModel *) objectWithResults:(FMResultSet *)results;
+ (ProducerCreditModel *) loadModel:(NSNumber *) pk;
+ (NSMutableArray *) loadByEntryId:(NSNumber *) entryPK;

+ (NSString *) modelFilterName;
+ (void) setModelFilterName:(NSString *) filterName;

+ (NSNumber *) modelFilterValue;
+ (void) setModelFilterValue:(NSNumber *) filterNumber;

- (NSNumber *) next;
- (NSNumber *) previous;
+ (NSNumber *) first;
+ (NSNumber *) last;

- (void) save;
- (void) deleteModel;

@end
