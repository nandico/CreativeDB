//
//  BaseLabel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/14/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseLabel.h"
#import "ClientEngine.h"

@implementation BaseLabel

- (id) init
{
    self = [super init];
    
    if( self )
    {
        self.textColor = PALLETE_BLACK_FOR_ELEMENTS;
    }
    
    return self;
}

@end
