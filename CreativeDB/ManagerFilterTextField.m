//
//  ManagerFilterTextField.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/4/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerFilterTextField.h"
#import "ManagerEngine.h"

@implementation ManagerFilterTextField

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect( MLE_FILTER_FIELD_OFFSET_X, MLE_FILTER_FIELD_OFFSET_Y, MLE_FILTER_FIELD_WIDTH, MLE_FILTER_FIELD_HEIGHT );
        [self setFont:MLE_FIELD_FONT];
        [self setTextColor:MLE_FIELD_COLOR];
        [self setBezelStyle:NSTextFieldRoundedBezel];
    }
    
    return self;
}

- (void) textDidBeginEditing:(NSNotification *)notification
{
    [super textDidBeginEditing:notification];
}

- (void) textDidEndEditing:(NSNotification *)notification
{
    [super textDidEndEditing:notification];
}


@end
