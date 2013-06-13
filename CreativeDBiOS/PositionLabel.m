//
//  PositionLabel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/11/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PositionLabel.h"
#import "ClientEngine.h"

@implementation PositionLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = POSITION_LABEL_COLOR;
        self.font = POSITION_LABEL_FONT;
        self.backgroundColor = POSITION_LABEL_BACKGROUND_COLOR;
    }
    return self;
}


@end
