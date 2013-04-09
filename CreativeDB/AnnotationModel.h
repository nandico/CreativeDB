//
//  AnnotationModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
#import "EntryModel.h"

@interface AnnotationModel : BaseModel

@property (strong) UserModel *user;
@property (strong) EntryModel *entry;
@property (strong) NSString *comment;
@property (assign) BOOL i_like;
@property (assign) BOOL i_rate;
@property (assign) BOOL i_made;
@property (strong) NSString *update_request;

+ (AnnotationModel *) objectWithResults:(FMResultSet *)results;
+ (NSMutableArray *) loadByEntryId:(NSNumber *) entryPK;

@end
