//
//  ManagerFilterComboBox.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/4/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerFilterComboBox.h"
#import "ManagerEngine.h"

@implementation ManagerFilterComboBox

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect( MLE_FILTER_FIELD_OFFSET_X, MLE_FILTER_FIELD_OFFSET_Y, MLE_FILTER_COMBO_WIDTH, MLE_FILTER_COMBO_HEIGHT );
        [self setFont:MLE_COMBO_FONT];
        [self setTextColor:MLE_COMBO_COLOR];
        [self setBezelStyle:NSTextFieldRoundedBezel];
        [self setCompletes:YES];
    }
    
    return self;
}

@end
