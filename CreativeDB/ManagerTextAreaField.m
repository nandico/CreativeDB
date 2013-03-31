//
//  ManagerTextAreaField.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/30/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerTextAreaField.h"
#import "ManagerEngine.h"

@implementation ManagerTextAreaField

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect( MLE_FIELD_OFFSET_X, MLE_FIELD_OFFSET_Y, MLE_FIELD_WIDTH, MLE_TEXT_FIELD_HEIGHT );
        [self.cell setWraps:YES];
    }
    
    return self;
}

@end

