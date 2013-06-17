//
//  HeaderViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "HeaderViewController.h"
#import "HeaderView.h"
#import "ClientEngine.h"

@interface HeaderViewController ()

@property (nonatomic, strong) HeaderView *viewInstance;

@end

@implementation HeaderViewController

- (id) init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void) loadView
{
    self.view = self.viewInstance = [[HeaderView alloc] initWithFrame:HEADER_LANDSCAPE_FRAME];
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
        self.viewInstance.frame = HEADER_PORTRAIT_FRAME;
        [self.viewInstance updateOrientation:orientation];
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        self.viewInstance.frame = HEADER_LANDSCAPE_FRAME;
        [self.viewInstance updateOrientation:orientation];
    }
}

- (void)viewDidLoad
{
    self.viewInstance.clipsToBounds = YES;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
