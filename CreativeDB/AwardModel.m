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
    object.metal = [MetalModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"metal"]]];
    object.category = [CategoryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"category"]]];
    object.entry = [EntryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"entry"]]];
    object.festival = [FestivalModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"festival"]]];
    object.subcategory = [SubcategoryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"subcategory"]]];
    object.year = [results longForColumn:@"year"];
    
    return object;
}

+ (AwardModel *) loadModel:(NSNumber *) pk
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
                            " id = %ld ", [pk integerValue] ];
    
    if( [results next] )
    {
        model = [AwardModel objectWithResults:results];
    }
    
    [results close];
    [db close];
    
    return model;
}

@end
