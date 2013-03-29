//
//  ManagerLabel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerLabel.h"
#import "ManagerEngine.h"

@implementation ManagerLabel

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect(MLE_LABEL_OFFSET_X, MLE_LABEL_OFFSET_Y, MLE_LABEL_WIDTH, MLE_LABEL_HEIGHT);
        [self setAlignment:NSRightTextAlignment];
        [self setBezeled:NO];
        [self setDrawsBackground:NO];
        [self setEditable:NO];
        [self setSelectable:NO];
    }
    
    return self;
}


@end
