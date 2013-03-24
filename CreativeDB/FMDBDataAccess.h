//
//  FMDBDataAccess.h
//  Reader
//
//  Created by Fernando Aquino on 2/17/13.
//  Copyright (c) 2013 Huge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "GroupModel.h"

#define SQLITE_FILE_NAME @"CreativeDB"

@interface FMDBDataAccess : NSObject

+ (FMDBDataAccess *)getInstance;

- (void)getSchema;
- (NSMutableArray *) getTableSchema:(NSString *)tableName;
- (GroupModel *) loadGroup:(NSInteger) pk;

@end
