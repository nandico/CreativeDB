//
//  MainViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "HeaderViewController.h"
#import "ScoreListViewController.h"

@interface MainViewController()

@property (strong, nonatomic) MainView *viewInstance;
@property (strong, nonatomic) HeaderViewController *header;
@property (strong, nonatomic) ScoreListViewController *scoreModule;

@property (nonatomic) UIDeviceOrientation currentOrientation;

@end

@implementation MainViewController

- (id) init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[MainView alloc] init];

        self.header = [[HeaderViewController alloc] init];
        [self.viewInstance addSubview:self.header.view];
    
        self.scoreModule = [[ScoreListViewController alloc] init];
        [self.viewInstance addSubview:self.scoreModule.view];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChange:)
                                                     name: UIDeviceOrientationDidChangeNotification
                                                   object: nil];
    
}
    
    return self;
}

- (void) deviceOrientationDidChange:(NSNotification *) notification
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if( orientation == UIDeviceOrientationFaceUp ||
       orientation == UIDeviceOrientationFaceDown ||
       orientation == UIDeviceOrientationUnknown ||
       _currentOrientation == orientation)
    {
        return;
    }
        
    _currentOrientation = orientation;
    [self performSelector:@selector(orientationChangedMethod) withObject:nil afterDelay:0];
}

- (void) orientationChangedMethod
{
    [self.header updateOrientation:_currentOrientation];
    [self.scoreModule updateOrientation:_currentOrientation];
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
