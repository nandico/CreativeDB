//
//  AgencyManagerCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/23/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AgencyManagerCompleteViewController.h"
#import "BaseLayeredView.h"

@interface AgencyManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;

@end

@implementation AgencyManagerCompleteViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[BaseLayeredView alloc] init];
        
        [self createForm];
    }
    
    return self;
}

- (void) createForm
{
    NSLog( @"Create form!" );
}

@end
