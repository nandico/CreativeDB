//
//  EntryManagerCompleteScrollView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/11/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryManagerCompleteScrollView.h"
#import "ManagerEngine.h"

@implementation EntryManagerCompleteScrollView

- (id)init
{
    self = [super init];
    if (self) {
        self.hasHorizontalRuler = YES;
        self.hasHorizontalScroller = YES;
        
        self.wantsLayer = YES;
        self.layer.backgroundColor = [MLE_BACKGROUND_COLOR CGColor];
        
        [self setNeedsDisplay:YES];
    }
    
    return self;
}

@end


