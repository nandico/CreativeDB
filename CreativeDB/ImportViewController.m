//
//  ImportViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 7/16/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ImportViewController.h"
#import "ImportView.h"

@interface ImportViewController()

@property (strong, nonatomic) ImportView *viewInstance;

@end

@implementation ImportViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void) loadView
{
    self.view = self.viewInstance = [[ImportView alloc] init];
}

@end
