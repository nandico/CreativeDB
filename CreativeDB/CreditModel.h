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

@property (assign) NSNumber *pk;
@property (strong) PersonModel *person;
@property (strong) EntryModel *entry;
@property (strong) RoleModel *role;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (CreditModel *) objectWithResults:(FMResultSet *)results;
+ (CreditModel *) loadModel:(NSNumber *) pk;
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
