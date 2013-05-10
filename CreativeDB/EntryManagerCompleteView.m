//
//  EntryManagerCompleteView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 4/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryManagerCompleteView.h"

@implementation EntryManagerCompleteView

- (id)init
{
    self = [super init];
    if (self) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [[NSColor whiteColor] CGColor];
    }
    return self;
}

@end
