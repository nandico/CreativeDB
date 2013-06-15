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

- (void) setText:(NSString *)text
{
    self.frame = self.superview.bounds;

    self.backgroundColor = THUMB_TEXT_BACKGROUND_COLOR;
    self.textColor = THUMB_TEXT_COLOR;
    self.font = THUMB_TEXT_FONT;
    
    self.textAlignment = NSTextAlignmentCenter;
    
    [super setText:text];
}

@end
