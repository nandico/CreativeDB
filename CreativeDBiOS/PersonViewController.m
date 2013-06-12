//
//  PersonViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/12/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonView.h"
#import "ClientEngine.h"

@interface PersonViewController ()

@property (strong, nonatomic) PersonView *viewInstance;

@property (nonatomic) UIDeviceOrientation currentOrientation;

@end

@implementation PersonViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[PersonView alloc] init];
    }
    return self;
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
        self.viewInstance.frame = LIST_PORTRAIT_FRAME;
        _currentOrientation = orientation;
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        self.viewInstance.frame = LIST_LANDSCAPE_FRAME;
        _currentOrientation = orientation;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
