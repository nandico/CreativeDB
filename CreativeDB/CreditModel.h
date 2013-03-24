//
//  CreditModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"
#import "PersonModel.h"
#import "EntryModel.h"
#import "RoleModel.h"

@interface CreditModel : BaseModel

@property (assign) NSInteger pk;
@property (strong) PersonModel *person;
@property (strong) EntryModel *entry;
@property (strong) RoleModel *role;

+ (CreditModel *) objectWithResults:(FMResultSet *)results;
+ (CreditModel *) loadModel:(NSInteger) pk;
+ (NSMutableArray *) loadByEntryId:(NSInteger) entryPK;


@end
