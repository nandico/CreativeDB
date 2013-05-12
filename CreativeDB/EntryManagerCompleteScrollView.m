//
//  EntryManagerCompleteScrollView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/11/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryManagerCompleteScrollView.h"

@implementation EntryManagerCompleteScrollView

- (id)init
{
    self = [super init];
    if (self) {
        self.hasHorizontalRuler = YES;
        self.hasHorizontalScroller = YES;
        [self setNeedsDisplay:YES];
    }
    
    return self;
}

@end
