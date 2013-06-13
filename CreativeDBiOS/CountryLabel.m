//
//  CountryLabel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/11/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CountryLabel.h"
#import "ClientEngine.h"

@implementation CountryLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = COUNTRY_LABEL_COLOR;
        self.font = COUNTRY_LABEL_FONT;
        self.backgroundColor = COUNTRY_LABEL_BACKGROUND_COLOR;
    }
    return self;
}


@end
