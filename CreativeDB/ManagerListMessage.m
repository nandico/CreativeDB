//
//  ManagerListMessage.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/8/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerListMessage.h"
#import "ManagerEngine.h"

@implementation ManagerListMessage

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect(MLE_LIST_LABEL_OFFSET_X, MLE_LIST_LABEL_OFFSET_Y, MLE_LIST_LABEL_WIDTH, MLE_LIST_LABEL_HEIGHT);
        [self setFont:MLE_LIST_LABEL_FONT];
        [self setTextColor:MLE_LIST_LABEL_COLOR];
        [self setAlignment:NSRightTextAlignment];
        [self setBezeled:NO];
        [self setDrawsBackground:NO];
        [self setEditable:NO];
        [self setSelectable:NO];
        [self.cell setWraps:YES];
        
    }
    
    return self;
}


@end
