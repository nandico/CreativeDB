//
//  AwardModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"
#import "MetalModel.h"
#import "CategoryModel.h"
#import "EntryModel.h"
#import "FestivalModel.h"
#import "SubcategoryModel.h"

@interface AwardModel : BaseModel

@property (strong) NSNumber *pk;
@property (strong) MetalModel *metal;
@property (strong) CategoryModel *category;
@property (strong) EntryModel *entry;
@property (strong) FestivalModel *festival;
@property (strong) SubcategoryModel *subcategory;
@property (strong) NSNumber *year;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (AwardModel *) objectWithResults:(FMResultSet *)results;
+ (AwardModel *) loadModel:(NSNumber *) pk;
+ (NSMutableArray *) loadByEntryId:(NSNumber *) entryPK;
+ (NSMutableArray *) loadAll;
+ (NSNumber *) modelCount;

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
