//
//  H3Label.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/13/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "H3Label.h"
#import "ClientEngine.h"

@implementation H3Label

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = H3_LABEL_COLOR;
        self.font = H3_LABEL_FONT;
        self.backgroundColor = H3_LABEL_BACKGROUND_COLOR;
    }
    return self;
}

@end
