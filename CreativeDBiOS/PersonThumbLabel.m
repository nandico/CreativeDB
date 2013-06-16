//
//  PersonThumbLabel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/15/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonThumbLabel.h"
#import "ClientEngine.h"

@implementation PersonThumbLabel

- (id) init
{
    self = [super init];
    
    if( self )
    {
        self.backgroundColor = [UIColor clearColor];
        self.textColor = THUMB_TEXT_COLOR;
        self.font = THUMB_TEXT_FONT;
        
        self.textAlignment = NSTextAlignmentCenter;
        
    }
    
    return self;
}

- (void) setText:(NSString *)text
{
    self.frame = self.superview.bounds;
    [super setText:text];
}

@end
