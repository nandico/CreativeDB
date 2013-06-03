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

@property (assign) NSNumber *pk;
@property (strong) AgencyModel *agency;
@property (strong) ClientModel *client;
@property (strong) CountryModel *country;
@property (strong) ProductModel *product;
@property (strong) NSURL *accessURL;
@property (strong) NSURL *caseURL;
@property (strong) NSString *blurb;
@property (strong) NSString *name;
@property (assign) NSNumber *year;

+ (NSString *) tableName;
+ (NSString *) fields;
+ (EntryModel *) objectWithResults:(FMResultSet *)results;
+ (EntryModel *) loadModel:(NSNumber *) pk;
+ (EntryModel *) loadModelByStringValue:(NSString *) stringValue;
+ (NSMutableArray *) loadAll;
+ (NSMutableArray *) loadByPersonId:(NSNumber *) personPK;

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



@end
