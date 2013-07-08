//
//  CountryLabel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/11/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CountryLabel.h"

@implementation CountryLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = PALLETE_BLACK_FOR_ELEMENTS;
        self.font = COUNTRY_LABEL_FONT;
        self.backgroundColor = COUNTRY_LABEL_BACKGROUND_COLOR;
    }
    return self;
}


@end
