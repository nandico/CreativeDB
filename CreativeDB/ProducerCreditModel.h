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

@property (assign) NSInteger pk;
@property (strong) EntryModel *entry;
@property (strong) ProducerModel *producer;
@property (strong) DisciplineModel *discipline;

+ (ProducerCreditModel *) objectWithResults:(FMResultSet *)results;
+ (ProducerCreditModel *) loadModel:(NSInteger) pk;
+ (NSMutableArray *) loadByEntryId:(NSInteger) entryPK;

@end
