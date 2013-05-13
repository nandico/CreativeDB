//
//  ManagerTextField.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerTextField.h"
#import "ManagerEngine.h"

@implementation ManagerTextField

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect( MLE_FIELD_OFFSET_X, MLE_FIELD_OFFSET_Y, MLE_FIELD_WIDTH, MLE_FIELD_HEIGHT );
        [self setFont:MLE_FIELD_FONT];
        [self setTextColor:MLE_FIELD_COLOR];
        [self setBezelStyle:NSTextFieldRoundedBezel];
    }

    return self;
}

- (void) textDidBeginEditing:(NSNotification *)notification
{
    NSLog( @"BEGIN!" );
    [super textDidBeginEditing:notification];
}

- (void) textDidEndEditing:(NSNotification *)notification
{
    NSLog( @"END!" );
    [super textDidEndEditing:notification];
}
@end
