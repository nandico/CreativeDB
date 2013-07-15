//
//  ManagerButton.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/31/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerButton.h"
#import "ManagerEngine.h"

@implementation ManagerButton

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect( MLE_BUTTON_OFFSET_X, MLE_BUTTON_OFFSET_Y, MLE_BUTTON_WIDTH, MLE_BUTTON_HEIGHT );
        [self setFont:MLE_MENU_BUTTON_FONT];
        [self setBezelStyle:NSTextFieldRoundedBezel];
    }
    
    return self;
}

@end
