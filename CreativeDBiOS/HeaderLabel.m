//
//  HeaderLabel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "HeaderLabel.h"

@implementation HeaderLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = PALLETE_BLACK_FOR_ELEMENTS;
        //self.backgroundColor = HEADER_TITLE_BACKGROUND_COLOR;
        self.font = HEADER_TITLE_FONT;
    }
    return self;
}

@end
