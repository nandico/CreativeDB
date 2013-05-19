//
//  MainManagerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/19/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "MainManagerView.h"
#import "ManagerEngine.h"

@implementation MainManagerView

- (id)init
{
    self = [super init];
    if (self) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [MLE_BACKGROUND_COLOR CGColor];
    }
    
    return self;
}

@end
