//
//  ScoreModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/27/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"
#import "EntryModel.h"
#import "FestivalModel.h"
#import "AgencyModel.h"
#import "ClientModel.h"
#import "CountryModel.h"
#import "GroupModel.h"
#import "PersonModel.h"
#import "ProducerModel.h"
#import "ProductModel.h"
#import "AwardModel.h"

@interface ScoreModel : BaseModel

@property (strong) NSNumber *pk;
@property (strong) NSNumber *origin;
@property (strong, nonatomic) AgencyModel *agency;
@property (strong, nonatomic) ClientModel *client;
@property (strong, nonatomic) CountryModel *country;
@property (strong, nonatomic) GroupModel *group;
@property (strong, nonatomic) PersonModel *person;
@property (strong, nonatomic) ProducerModel *producer;
@property (strong, nonatomic) ProductModel *product;
@property (strong, nonatomic) EntryModel *entry;
@property (strong, nonatomic) FestivalModel *festival;
@property (strong) NSNumber *year;
@property (strong) NSNumber *score;

+ (NSString *) tableName;
+ (void) setTableName: (NSString *) name;
+ (NSString *) fields;
+ (ScoreModel *) objectWithResults:(FMResultSet *)results;
+ (ScoreModel *) loadModel:(NSNumber *) pk;
+ (ScoreModel *) loadModelByStringValue:(NSString *) stringValue;
+ (NSMutableArray *) loadAll;
+ (void) resetScore:(NSString *) tableName;

+ (NSMutableArray *) loadRankingByTableName: (NSString *) tableName;
+ (NSMutableArray *) loadRankingByTableName: (NSString *) tableName andFilters:(NSMutableDictionary *) filters;

+ (void) updateScoreForTablename:(NSString *) tableName
                       withAward:(AwardModel *) award
                       forOrigin:(NSNumber *) origin
                       withScore:(NSNumber *) score;
+ (NSInteger) calculateScoreWithTablename:(NSString *) tableName forOrigin:(NSNumber *) origin andYear:(NSNumber *) year;

- (void) save;
- (void) deleteModel;

@end
