//
//  LineModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/14/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LineModel : NSObject

@property (assign) NSInteger lineIndex;
@property (strong) NSNumber *width;
@property (strong) NSNumber *height;
@property (strong) NSMutableArray *columns;

- (id) initWithOptions:(NSMutableArray *) columns;

@end
