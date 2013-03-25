//
//  AwardModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AwardModel.h"
#import "FMDBDataAccess.h"
#import "CreditModel.h"
#import "ProducerCreditModel.h"

@implementation AwardModel

+ (AwardModel *) objectWithResults:(FMResultSet *)results
{
    AwardModel *object = [[AwardModel alloc] init];
    object.pk = [results longForColumn:@"id"];
    object.metal = [MetalModel loadModel:[results longForColumn:@"metal"]];
    object.category = [CategoryModel loadModel:[results longForColumn:@"category"]];
    object.entry = [EntryModel loadModel:[results longForColumn:@"entry"]];
    object.festival = [FestivalModel loadModel:[results longForColumn:@"festival"]];
    object.subcategory = [SubcategoryModel loadModel:[results longForColumn:@"subcategory"]];
    object.year = [results longForColumn:@"year"];
    
    return object;
}

+ (AwardModel *) loadModel:(NSInteger) pk
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    AwardModel *model;
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " id, metal, category, entry, festival, subcategory, year "
                            " FROM aa_award "
                            " WHERE "
                            " id = %ld ", pk ];
    
    if( [results next] )
    {
        model = [AwardModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

- (NSMutableArray *) credits
{
    return [CreditModel loadByEntryId:self.entry.pk];
}

- (NSMutableArray *) producers
{
    return [ProducerCreditModel loadByEntryId:self.entry.pk];
}

@end
