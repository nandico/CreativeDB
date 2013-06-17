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
        self.viewInstance = [[HeaderView alloc] initWithFrame:HEADER_LANDSCAPE_FRAME];
        [self.view addSubview:self.viewInstance];
    }
    return self;
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
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
