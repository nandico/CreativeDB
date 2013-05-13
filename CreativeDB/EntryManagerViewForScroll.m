//
//  EntryManagerViewForScroll.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/13/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryManagerViewForScroll.h"
#import "ManagerEngine.h"

@implementation EntryManagerViewForScroll

- (id)init
{
    self = [super init];
    if (self) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [MLE_BACKGROUND_COLOR CGColor];
    }
    return self;
}

@end
