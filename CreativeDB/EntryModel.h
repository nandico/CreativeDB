//
//  EntryModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"
#import "AgencyModel.h"
#import "ClientModel.h"
#import "ProductModel.h"
#import "CountryModel.h"

@interface EntryModel : BaseModel

@property (strong) NSNumber *pk;
@property (strong, nonatomic) AgencyModel *agency;
@property (strong, nonatomic) ClientModel *client;
@property (strong, nonatomic) CountryModel *country;
@property (strong, nonatomic) ProductModel *product;
@property (strong) NSURL *accessURL;
@property (strong) NSURL *caseURL;
@property (strong) NSString *blurb;
@property (strong) NSString *name;
@property (strong) NSNumber *year;
@property (strong, nonatomic) NSNumber *rankingGlobal;
@property (strong, nonatomic) NSNumber *rankingCountry;


+ (NSString *) tableName;
+ (NSString *) fields;
+ (EntryModel *) objectWithResults:(FMResultSet *)results;
+ (EntryModel *) loadModel:(NSNumber *) pk;
+ (EntryModel *) loadModelByStringValue:(NSString *) stringValue;
+ (NSMutableArray *) loadAll;
+ (NSMutableArray *) loadByPersonId:(NSNumber *) personPK;
+ (NSMutableArray *) loadByAgencyId:(NSNumber *) agencyPK;

- (NSNumber *) next;
- (NSNumber *) previous;
+ (NSNumber *) first;
+ (NSNumber *) last;

- (NSMutableArray *) credits;
- (NSMutableArray *) producers;
- (NSMutableArray *) annotations;
- (NSMutableArray *) awards;
- (void) save;
- (void) deleteModel;

- (NSInteger) calculateRankGlobal:(NSNumber *) year;
- (NSInteger) calculateRankCountry:(NSNumber *) year;

@end
