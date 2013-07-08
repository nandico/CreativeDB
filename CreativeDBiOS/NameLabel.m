//
//  NameLabel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/11/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "NameLabel.h"

@implementation NameLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = PALLETE_BLACK_FOR_ELEMENTS;
        self.font = NAME_LABEL_FONT;
        self.backgroundColor = NAME_LABEL_BACKGROUND_COLOR;
    }
    return self;
}

@end
