//
//  H1Label.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/13/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "H1Label.h"

@implementation H1Label

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = H1_LABEL_COLOR;
        self.font = H1_LABEL_FONT;
        self.backgroundColor = H1_LABEL_BACKGROUND_COLOR;
    }
    return self;
}


@end
