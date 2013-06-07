//
//  ScoreController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/27/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ScoreController.h"
#import "AwardModel.h"
#import "CreditModel.h"
#import "ScoreModel.h"
#import "ProducerCreditModel.h"
#import "AgencyModel.h"
#import "ClientModel.h"
#import "CountryModel.h"
#import "GroupModel.h"
#import "ProductModel.h"

@implementation ScoreController

+ (void) processAwards
{
    [self resetAwards];
    
    NSMutableArray *awards = [AwardModel loadAll];
    
    for( AwardModel *award in awards )
    {    
        // people credits
        for( CreditModel *credit in award.entry.credits )
        {
            [self insertScore:award forCredit:credit];
        }
        
        // producer credits
        for( ProducerCreditModel *producer in award.entry.producers )
        {
            [self insertScore:award forProducer:producer];
        }
        
        // agency credits
        [self insertScore:award forAgency:award.entry.agency];
        
        // client credits
        [self insertScore:award forClient:award.entry.client];
        
        // country credits
        [self insertScore:award forCountry:award.entry.agency.country];
        
        // group credits
        [self insertScore:award forGroup:award.entry.agency.group];
        
        // product credits
        [self insertScore:award forProduct:award.entry.product];
    }
}

+ (void) resetAwards
{
    [ScoreModel resetScore:@"aa_person_score"];
    [ScoreModel resetScore:@"aa_producer_score"];
    [ScoreModel resetScore:@"aa_agency_score"];
    [ScoreModel resetScore:@"aa_client_score"];
    [ScoreModel resetScore:@"aa_country_score"];
    [ScoreModel resetScore:@"aa_group_score"];
    [ScoreModel resetScore:@"aa_product_score"];
}

+ (void) insertScore:(AwardModel *) award forCredit:(CreditModel *) credit
{
    [ScoreModel setTableName:@"aa_person_score"];
    
    ScoreModel *score = [[ScoreModel alloc] init];
    score.origin = credit.person.pk;
    score.country = credit.person.country;
    score.entry = [EntryModel loadModel:award.entry.pk];
    score.festival = [FestivalModel loadModel:award.festival.pk];
    score.year = award.year;
    score.score = [NSNumber numberWithInteger:[award.festival.weight integerValue] * [award.metal.weight integerValue]];
    
    [score save];
}

+ (void) insertScore:(AwardModel *) award forProducer:(ProducerCreditModel *) producer
{
    [ScoreModel setTableName:@"aa_producer_score"];
    
    ScoreModel *score = [[ScoreModel alloc] init];
    score.origin = producer.producer.pk;
    score.country = producer.producer.country;
    score.entry = [EntryModel loadModel:award.entry.pk];
    score.festival = [FestivalModel loadModel:award.festival.pk];
    score.year = award.year;
    score.score = [NSNumber numberWithInteger:[award.festival.weight integerValue] * [award.metal.weight integerValue]];
    
    [score save];
    
}

+ (void) insertScore:(AwardModel *) award forAgency:(AgencyModel *) agency
{
    [ScoreModel setTableName:@"aa_agency_score"];
    
    ScoreModel *score = [[ScoreModel alloc] init];
    score.origin = agency.pk;
    score.country = agency.country;
    score.entry = [EntryModel loadModel:award.entry.pk];
    score.festival = [FestivalModel loadModel:award.festival.pk];
    score.year = award.year;
    score.score = [NSNumber numberWithInteger:[award.festival.weight integerValue] * [award.metal.weight integerValue]];
    
    [score save];
}

+ (void) insertScore:(AwardModel *) award forClient:(ClientModel *) client
{
    [ScoreModel setTableName:@"aa_client_score"];
    
    ScoreModel *score = [[ScoreModel alloc] init];
    score.origin = client.pk;
    score.country = client.country;
    score.entry = [EntryModel loadModel:award.entry.pk];
    score.festival = [FestivalModel loadModel:award.festival.pk];
    score.year = award.year;
    score.score = [NSNumber numberWithInteger:[award.festival.weight integerValue] * [award.metal.weight integerValue]];
    
    [score save];
}

+ (void) insertScore:(AwardModel *) award forCountry:(CountryModel *) country
{
    [ScoreModel setTableName:@"aa_country_score"];
    
    ScoreModel *score = [[ScoreModel alloc] init];
    score.origin = country.pk;
    score.country = country;
    score.entry = [EntryModel loadModel:award.entry.pk];
    score.festival = [FestivalModel loadModel:award.festival.pk];
    score.year = award.year;
    score.score = [NSNumber numberWithInteger:[award.festival.weight integerValue] * [award.metal.weight integerValue]];
    
    [score save];
}

+ (void) insertScore:(AwardModel *) award forGroup:(GroupModel *) group
{
    [ScoreModel setTableName:@"aa_group_score"];
        
    ScoreModel *score = [[ScoreModel alloc] init];
    score.origin = group.pk;
    score.country = nil;
    score.entry = [EntryModel loadModel:award.entry.pk];
    score.festival = [FestivalModel loadModel:award.festival.pk];
    score.year = award.year;
    score.score = [NSNumber numberWithInteger:[award.festival.weight integerValue] * [award.metal.weight integerValue]];
    
    [score save];
}

+ (void) insertScore:(AwardModel *) award forProduct:(ProductModel *) product
{
    if( !product ) return;
    
    [ScoreModel setTableName:@"aa_product_score"];
    
    ScoreModel *score = [[ScoreModel alloc] init];
    score.origin = product.pk;
    score.country = product.client.country;
    score.entry = [EntryModel loadModel:award.entry.pk];
    score.festival = [FestivalModel loadModel:award.festival.pk];
    score.year = award.year;
    score.score = [NSNumber numberWithInteger:[award.festival.weight integerValue] * [award.metal.weight integerValue]];
    
    [score save];
}

@end
