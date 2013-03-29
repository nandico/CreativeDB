//
//  ManagerTextField.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerTextField.h"
#import "ManagerLayoutEngine.h"

@implementation ManagerTextField

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = NSMakeRect( 0.0f, 0.0f, MLE_FIELD_WIDTH, MLE_FIELD_HEIGHT );
    }
    
    return self;
}
@end
