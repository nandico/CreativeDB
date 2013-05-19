//
//  ManagerMenuButton.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/19/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerMenuButton.h"
#import "ManagerEngine.h"

@implementation ManagerMenuButton

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect( MLE_MENU_BUTTON_OFFSET_X, MLE_MENU_BUTTON_OFFSET_Y, MLE_MENU_BUTTON_WIDTH, MLE_MENU_BUTTON_HEIGHT );
        [self setFont:MLE_BUTTON_FONT];
        [self setBezelStyle:NSTextFieldSquareBezel];
    }
    
    return self;
}

@end
