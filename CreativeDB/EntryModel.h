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

@interface EntryModel : BaseModel

@property (assign) NSInteger pk;
@property (strong) AgencyModel *agency;
@property (strong) ClientModel *client;
@property (strong) ProductModel *product;
@property (strong) NSURL *accessURL;
@property (strong) NSURL *caseURL;
@property (strong) NSString *blurb;
@property (strong) NSString *name;
@property (assign) NSInteger year;

+ (EntryModel *) objectWithResults:(FMResultSet *)results;
+ (EntryModel *) loadModel:(NSInteger) pk;

@end
