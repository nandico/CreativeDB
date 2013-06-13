//
//  H4Label.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/13/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "H4Label.h"
#import "ClientEngine.h"

@implementation H4Label

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = H4_LABEL_COLOR;
        self.font = H4_LABEL_FONT;
        self.backgroundColor = H4_LABEL_BACKGROUND_COLOR;
    }
    return self;
}

@end
