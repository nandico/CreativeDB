//
//  ManagerSubmenuButton.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerSubmenuButton.h"
#import "ManagerEngine.h"

@implementation ManagerSubmenuButton

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect( MLE_SUBMENU_BUTTON_OFFSET_X, MLE_SUBMENU_BUTTON_OFFSET_Y, MLE_SUBMENU_BUTTON_WIDTH, MLE_SUBMENU_BUTTON_HEIGHT );
        [self setFont:MLE_BUTTON_FONT];
        [self setBezelStyle:NSTextFieldSquareBezel];
    }
    
    return self;
}

@end
