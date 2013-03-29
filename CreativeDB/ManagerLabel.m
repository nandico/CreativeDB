//
//  ManagerLabel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerLabel.h"
#import "ManagerLayoutEngine.h"

@implementation ManagerLabel

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect( 0.0f, 80.0f, MLE_FIELD_WIDTH, MLE_FIELD_HEIGHT );
        [self setStringValue:@"My Label"];
        [self setBezeled:NO];
        [self setDrawsBackground:NO];
        [self setEditable:NO];
        [self setSelectable:NO];
    }
    
    return self;
}


@end
