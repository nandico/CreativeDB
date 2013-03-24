//
//  GroupModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface GroupModel : BaseModel

@property (assign) NSInteger pk;
@property (strong) NSString *name;

+ (GroupModel *) objectWithResults:(FMResultSet *)results;
+ (GroupModel *) loadModel:(NSInteger) pk;

@end
