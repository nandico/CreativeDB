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
    NSLog( @"Begin of awards processing..." );
    
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
        if( award.entry.product ) [self insertScore:award forProduct:award.entry.product];
        
        // entry credits
        // product credits
        [self insertScoreForEntry:award];

    }
    
    // 2nd loop to update ranking
    for( AwardModel *award in awards )
    {
        // ranking for agency
        [self updateEntityScore:award forAgency:award.entry.agency];

        // ranking for entry
        [self updateEntityScore:award forEntry:award.entry];
        
        // ranking for people
        for( CreditModel *credit in award.entry.credits )
        {
            [self updateEntityScore:award forCredit:credit];
        }
        
        // ranking for client
        [self updateEntityScore:award forClient:award.entry.client];

        // ranking for country
        [self updateEntityScore:award forCountry:award.entry.country];

        // ranking for group
        [self updateEntityScore:award forGroup:award.entry.agency.group];
        
        // ranking for product
        if( award.entry.product ) [self updateEntityScore:award forProduct:award.entry.product];
        
        // ranking producer credits
        for( ProducerCreditModel *producer in award.entry.producers )
        {
            [self updateEntityScore:award forProducer:producer.producer];
        }

    }

    // general ranking update
    [ScoreModel processRanking:@2013];
    
    NSLog( @"End of awards processing..." );
    
}

+ (void) resetAwards
{
    [ScoreModel resetScore:@"aa_person_score"];
    [ScoreModel resetScore:@"aa_person_score_year"];
    [ScoreModel resetScore:@"aa_producer_score"];
    [ScoreModel resetScore:@"aa_producer_score_year"];
    [ScoreModel resetScore:@"aa_agency_score"];
    [ScoreModel resetScore:@"aa_agency_score_year"];
    [ScoreModel resetScore:@"aa_client_score"];
    [ScoreModel resetScore:@"aa_client_score_year"];
    [ScoreModel resetScore:@"aa_country_score"];
    [ScoreModel resetScore:@"aa_country_score_year"];
    [ScoreModel resetScore:@"aa_group_score"];
    [ScoreModel resetScore:@"aa_group_score_year"];
    [ScoreModel resetScore:@"aa_product_score"];
    [ScoreModel resetScore:@"aa_product_score_year"];
    [ScoreModel resetScore:@"aa_entry_score"];
    [ScoreModel resetScore:@"aa_entry_score_year"];
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

+ (void) updateEntityScore:(AwardModel *) award forCredit:(CreditModel *) credit
{

    [ScoreModel updateScoreForTablename:@"aa_person_score_year"
                              withAward:award forOrigin:credit.personPK
                              withScore:[NSNumber numberWithInteger:[ScoreModel calculateScoreWithTablename:@"aa_person_score"
                                                                                                  forOrigin:credit.personPK
                                                                                                    andYear:award.year]]];

}

+ (void) updateEntityScore:(AwardModel *) award forAgency:(AgencyModel *) agency
{
    
    [ScoreModel updateScoreForTablename:@"aa_agency_score_year"
                              withAward:award forOrigin:agency.pk
                              withScore:[NSNumber numberWithInteger:[ScoreModel calculateScoreWithTablename:@"aa_agency_score"
                                                                                                  forOrigin:agency.pk
                                                                                                    andYear:award.year]]];
    
}

+ (void) updateEntityScore:(AwardModel *) award forEntry:(EntryModel *) entry
{
    
    [ScoreModel updateScoreForTablename:@"aa_entry_score_year"
                              withAward:award forOrigin:entry.pk
                              withScore:[NSNumber numberWithInteger:[ScoreModel calculateScoreWithTablename:@"aa_entry_score"
                                                                                                  forOrigin:entry.pk
                                                                                                    andYear:award.year]]];
    
}

+ (void) updateEntityScore:(AwardModel *) award forProducer:(ProducerModel *) producer
{
    
    [ScoreModel updateScoreForTablename:@"aa_producer_score_year"
                              withAward:award forOrigin:producer.pk
                              withScore:[NSNumber numberWithInteger:[ScoreModel calculateScoreWithTablename:@"aa_producer_score"
                                                                                                  forOrigin:producer.pk
                                                                                                    andYear:award.year]]];
    
}

+ (void) updateEntityScore:(AwardModel *) award forClient:(ClientModel *) client
{
    
    [ScoreModel updateScoreForTablename:@"aa_client_score_year"
                              withAward:award forOrigin:client.pk
                              withScore:[NSNumber numberWithInteger:[ScoreModel calculateScoreWithTablename:@"aa_client_score"
                                                                                                  forOrigin:client.pk
                                                                                                    andYear:award.year]]];
    
}

+ (void) updateEntityScore:(AwardModel *) award forCountry:(CountryModel *) country
{
    
    [ScoreModel updateScoreForTablename:@"aa_country_score_year"
                              withAward:award forOrigin:country.pk
                              withScore:[NSNumber numberWithInteger:[ScoreModel calculateScoreWithTablename:@"aa_country_score"
                                                                                                  forOrigin:country.pk
                                                                                                    andYear:award.year]]];
    
}

+ (void) updateEntityScore:(AwardModel *) award forGroup:(GroupModel *) group
{
    
    [ScoreModel updateScoreForTablename:@"aa_group_score_year"
                              withAward:award forOrigin:group.pk
                              withScore:[NSNumber numberWithInteger:[ScoreModel calculateScoreWithTablename:@"aa_group_score"
                                                                                                  forOrigin:group.pk
                                                                                                    andYear:award.year]]];
    
}

+ (void) updateEntityScore:(AwardModel *) award forProduct:(ProductModel *) product
{
    
    [ScoreModel updateScoreForTablename:@"aa_product_score_year"
                              withAward:award forOrigin:product.pk
                              withScore:[NSNumber numberWithInteger:[ScoreModel calculateScoreWithTablename:@"aa_product_score"
                                                                                                  forOrigin:product.pk
                                                                                                    andYear:award.year]]];
    
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
    score.country = group.country;
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

+ (void) insertScoreForEntry:(AwardModel *) award
{
    [ScoreModel setTableName:@"aa_entry_score"];
    
    ScoreModel *score = [[ScoreModel alloc] init];
    score.origin = award.entry.pk;
    score.country = award.entry.country;
    score.entry = award.entry;
    score.festival = [FestivalModel loadModel:award.festival.pk];
    score.year = award.year;
    score.score = [NSNumber numberWithInteger:[award.festival.weight integerValue] * [award.metal.weight integerValue]];
    
    [score save];
}

@end
