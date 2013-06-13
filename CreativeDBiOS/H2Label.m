//
//  H2Label.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/13/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "H2Label.h"
#import "ClientEngine.h"

@implementation H2Label

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = H2_LABEL_COLOR;
        self.font = H2_LABEL_FONT;
        self.backgroundColor = H2_LABEL_BACKGROUND_COLOR;
    }
    return self;
}

@end
