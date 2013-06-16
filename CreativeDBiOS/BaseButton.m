//
//  BaseButton.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/14/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton 

- (id)init
{
    self = [super init];
    if (self) {
        self.titleLabel.font = MENU_BUTTON_FONT;
        self.titleLabel.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end
