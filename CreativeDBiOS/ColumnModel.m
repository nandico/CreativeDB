//
//  ColumnModel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/14/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ColumnModel.h"

@implementation ColumnModel

- (id) initWithPercent:(NSNumber *) percent
{
    self = [super init];
    if (self) {
        self.percentWidth = percent;
    }
    
    return self;
}

- (id) initWithFixed:(NSNumber *) fixed
{
    self = [super init];
    if (self) {
        self.width = fixed;
    }
    
    return self;
}

@end
