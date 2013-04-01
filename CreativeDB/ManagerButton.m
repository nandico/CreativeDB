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
        self.frame = NSMakeRect( MLE_FIELD_OFFSET_X, MLE_FIELD_OFFSET_Y, MLE_BUTTON_WIDTH, MLE_BUTTON_HEIGHT );
    }
    
    return self;
}

@end
