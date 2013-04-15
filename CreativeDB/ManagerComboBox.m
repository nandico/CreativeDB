//
//  ManagerComboBox.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerComboBox.h"
#import "ManagerEngine.h"

@implementation ManagerComboBox

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect( MLE_FIELD_OFFSET_X, MLE_FIELD_OFFSET_Y, MLE_FIELD_WIDTH, MLE_FIELD_HEIGHT );
        [self setFont:MLE_COMBO_FONT];
        [self setTextColor:MLE_COMBO_COLOR];
        [self setCompletes:YES];
    }
    
    return self;
}

@end
