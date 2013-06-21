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
#import "PersonViewController.h"
#import "AgencyViewController.h"

@interface MainViewController()

@property (strong, nonatomic) MainView *viewInstance;
@property (strong, nonatomic) HeaderViewController *header;
@property (strong, nonatomic) ScoreListViewController *scoreModule;
@property (strong, nonatomic) PersonViewController *personDetail;
@property (strong, nonatomic) AgencyViewController *agencyDetail;

@property (nonatomic) UIDeviceOrientation currentOrientation;

@end

@implementation MainViewController

- (id) init
{
    self = [super init];
    if (self) {
     
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChange:)
                                                     name: UIDeviceOrientationDidChangeNotification
                                                   object: nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enablePersonDetail)
                                                     name:NOTIFICATION_WAKE_PERSON_DETAIL object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableAgencyDetail)
                                                     name:NOTIFICATION_WAKE_AGENCIES_DETAIL object:nil];

    }
    
    return self;
}

- (void) enablePersonDetail
{
    [self.personDetail.view setHidden:NO];
    [self.agencyDetail.view setHidden:YES];
}

- (void) enableAgencyDetail
{
    [self.personDetail.view setHidden:YES];
    [self.agencyDetail.view setHidden:NO];
}

- (void) loadView
{
    self.view = self.viewInstance = [[MainView alloc] initWithFrame:SCREEN_LANDSCAPE_FRAME];
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
    if( !_currentOrientation )
    {
        _currentOrientation = UIDeviceOrientationPortrait;
    }
    
    [self.header updateOrientation:_currentOrientation];
    [self.personDetail updateOrientation:_currentOrientation];
    [self.agencyDetail updateOrientation:_currentOrientation];
    [self.scoreModule updateOrientation:_currentOrientation];
}

- (void)viewDidLoad
{
    self.header = [[HeaderViewController alloc] init];
    [self.viewInstance addSubview:self.header.view];
    
    self.personDetail = [[PersonViewController alloc] init];
    [self.viewInstance addSubview:self.personDetail.view];
    [self.personDetail.view setHidden:YES];
    
    self.agencyDetail = [[AgencyViewController alloc] init];
    [self.viewInstance addSubview:self.agencyDetail.view];
    [self.personDetail.view setHidden:YES];
    
    self.scoreModule = [[ScoreListViewController alloc] init];
    [self.viewInstance addSubview:self.scoreModule.view];
        
    [self orientationChangedMethod];

    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
