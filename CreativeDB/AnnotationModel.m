//
//  AnnotationModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AnnotationModel.h"
#import "FMDBDataAccess.h"
#import "PersonModel.h"
#import "EntryModel.h"

@implementation AnnotationModel

+ (AnnotationModel *) objectWithResults:(FMResultSet *)results
{
    AnnotationModel *object = [[AnnotationModel alloc] init];
    object.user = [UserModel loadModel:[results longForColumn:@"user"]];
    object.entry = [EntryModel loadModel:[NSNumber numberWithLong:[results longForColumn:@"entry"]]];
    object.comment = [results stringForColumn:@"comment"];
    object.i_like = [results boolForColumn:@"i_like"];
    object.i_rate = [results boolForColumn:@"i_rate"];
    object.i_made = [results boolForColumn:@"i_made"];
    object.update_request = [results stringForColumn:@"update_request"];
    
    return object;
}

+ (NSMutableArray *) loadByEntryId:(NSInteger) entryPK
{
    NSString *path = [[NSBundle mainBundle] pathForResource:SQLITE_FILE_NAME
                                                     ofType:@"sqlite"];
    
    AnnotationModel *model;
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *results = [db executeQueryWithFormat:@"SELECT "
                            " user, entry, comment, i_like, i_rate, i_made, update_request "
                            " FROM aa_annotation "
                            " WHERE "
                            " entry = %ld ", entryPK ];
    
    while( [results next] )
    {
        model = [AnnotationModel objectWithResults:results];
        [collection addObject:model];
    }
    
    [results close];
    [db close];
    
    return collection;
}


@end
