//
//  LineModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/14/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "LineModel.h"

@implementation LineModel

- (id) initWithOptions:(NSMutableArray *) columns
{
    self = [super init];
    if (self) {
        self.columns = columns;
    }
    
    return self;
}

@end
