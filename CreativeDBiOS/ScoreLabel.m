//
//  ScoreLabel.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/11/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ScoreLabel.h"

@implementation ScoreLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = SCORE_LABEL_COLOR;
        self.font = SCORE_LABEL_FONT;
        self.backgroundColor = SCORE_LABEL_BACKGROUND_COLOR;
    }
    return self;
}


@end
