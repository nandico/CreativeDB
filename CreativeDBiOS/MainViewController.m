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
#import "DashboardViewController.h"
#import "ScoreListViewController.h"
#import "PersonViewController.h"
#import "AgencyViewController.h"
#import "EntryViewController.h"
#import "ClientViewController.h"
#import "CountryViewController.h"
#import "GroupViewController.h"
#import "ScoreModel.h"

@interface MainViewController()

@property (strong, nonatomic) MainView *viewInstance;
@property (strong, nonatomic) HeaderViewController *header;
@property (strong, nonatomic) DashboardViewController *dashboard;
@property (strong, nonatomic) ScoreListViewController *scoreModule;
@property (strong, nonatomic) PersonViewController *personDetail;
@property (strong, nonatomic) AgencyViewController *agencyDetail;
@property (strong, nonatomic) EntryViewController *entryDetail;
@property (strong, nonatomic) ClientViewController *clientDetail;
@property (strong, nonatomic) GroupViewController *groupDetail;
@property (strong, nonatomic) CountryViewController *countryDetail;

@property (nonatomic) UIDeviceOrientation currentOrientation;

@end

@implementation MainViewController

- (id) init
{
    self = [super init];
    if (self) {
        
        // scores
     
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChange:)
                                                     name: UIDeviceOrientationDidChangeNotification
                                                   object: nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableScore)
                                                     name:NOTIFICATION_WAKE_PERSON_SCORE object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableScore)
                                                     name:NOTIFICATION_WAKE_AGENCIES_SCORE object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableScore)
                                                     name:NOTIFICATION_WAKE_ENTRIES_SCORE object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableScore)
                                                     name:NOTIFICATION_WAKE_CLIENTS_SCORE object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableScore)
                                                     name:NOTIFICATION_WAKE_COUNTRIES_SCORE object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableScore)
                                                     name:NOTIFICATION_WAKE_GROUPS_SCORE object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableScore)
                                                     name:NOTIFICATION_WAKE_PRODUCERS_SCORE object:nil];
        
        // details
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableDashboard)
                                                     name:NOTIFICATION_WAKE_DASHBOARD object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enablePersonDetail)
                                                     name:NOTIFICATION_WAKE_PERSON_DETAIL object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableAgencyDetail)
                                                     name:NOTIFICATION_WAKE_AGENCIES_DETAIL object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableEntryDetail)
                                                     name:NOTIFICATION_WAKE_ENTRIES_DETAIL object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableClientDetail)
                                                     name:NOTIFICATION_WAKE_CLIENTS_DETAIL object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableCountryDetail)
                                                     name:NOTIFICATION_WAKE_COUNTRIES_DETAIL object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enableGroupDetail)
                                                     name:NOTIFICATION_WAKE_GROUPS_DETAIL object:nil];
 
    }
    
    return self;
}

- (void) enableScore
{
    [self.dashboard.view setHidden:YES];
    [self.personDetail.view setHidden:YES];
    [self.agencyDetail.view setHidden:YES];
    [self.entryDetail.view setHidden:YES];
    [self.clientDetail.view setHidden:YES];
    [self.countryDetail.view setHidden:YES];
    [self.groupDetail.view setHidden:YES];
    [self.scoreModule.view setHidden:NO];
}

- (void) enableDashboard
{
    [self.dashboard.view setHidden:NO];
    [self.personDetail.view setHidden:YES];
    [self.agencyDetail.view setHidden:YES];
    [self.entryDetail.view setHidden:YES];
    [self.clientDetail.view setHidden:YES];
    [self.countryDetail.view setHidden:YES];
    [self.groupDetail.view setHidden:YES];
    [self.scoreModule.view setHidden:NO];
}

- (void) enablePersonDetail
{
    [self.dashboard.view setHidden:YES];
    [self.personDetail.view setHidden:NO];
    [self.agencyDetail.view setHidden:YES];
    [self.entryDetail.view setHidden:YES];
    [self.clientDetail.view setHidden:YES];
    [self.countryDetail.view setHidden:YES];
    [self.groupDetail.view setHidden:YES];
    [self.scoreModule.view setHidden:NO];
}

- (void) enableAgencyDetail
{
    [self.dashboard.view setHidden:YES];
    [self.personDetail.view setHidden:YES];
    [self.agencyDetail.view setHidden:NO];
    [self.entryDetail.view setHidden:YES];
    [self.clientDetail.view setHidden:YES];
    [self.countryDetail.view setHidden:YES];
    [self.groupDetail.view setHidden:YES];
    [self.scoreModule.view setHidden:NO];
}

- (void) enableEntryDetail
{
    [self.dashboard.view setHidden:YES];
    [self.personDetail.view setHidden:YES];
    [self.agencyDetail.view setHidden:YES];
    [self.entryDetail.view setHidden:NO];
    [self.clientDetail.view setHidden:YES];
    [self.countryDetail.view setHidden:YES];
    [self.groupDetail.view setHidden:YES];
    [self.scoreModule.view setHidden:NO];
}

- (void) enableClientDetail
{
    [self.dashboard.view setHidden:YES];
    [self.personDetail.view setHidden:YES];
    [self.agencyDetail.view setHidden:YES];
    [self.entryDetail.view setHidden:YES];
    [self.clientDetail.view setHidden:NO];
    [self.countryDetail.view setHidden:YES];
    [self.groupDetail.view setHidden:YES];
    [self.scoreModule.view setHidden:NO];
}

- (void) enableCountryDetail
{
    [self.dashboard.view setHidden:YES];
    [self.personDetail.view setHidden:YES];
    [self.agencyDetail.view setHidden:YES];
    [self.entryDetail.view setHidden:YES];
    [self.clientDetail.view setHidden:YES];
    [self.countryDetail.view setHidden:NO];
    [self.groupDetail.view setHidden:YES];
    [self.scoreModule.view setHidden:NO];
}

- (void) enableGroupDetail
{
    [self.dashboard.view setHidden:YES];
    [self.personDetail.view setHidden:YES];
    [self.agencyDetail.view setHidden:YES];
    [self.entryDetail.view setHidden:YES];
    [self.clientDetail.view setHidden:YES];
    [self.countryDetail.view setHidden:YES];
    [self.groupDetail.view setHidden:NO];
    [self.scoreModule.view setHidden:NO];
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
    [self.dashboard updateOrientation:_currentOrientation];
    [self.personDetail updateOrientation:_currentOrientation];
    [self.agencyDetail updateOrientation:_currentOrientation];
    [self.entryDetail updateOrientation:_currentOrientation];
    [self.clientDetail updateOrientation:_currentOrientation];
    [self.scoreModule updateOrientation:_currentOrientation];
    [self.countryDetail updateOrientation:_currentOrientation];
    [self.groupDetail updateOrientation:_currentOrientation];
    
}

- (void)viewDidLoad
{
    // set current application year
    [ScoreModel setRankYear:@2013];
    
    self.header = [[HeaderViewController alloc] init];
    [self.viewInstance addSubview:self.header.view];
    
    self.personDetail = [[PersonViewController alloc] init];
    [self.viewInstance addSubview:self.personDetail.view];
    [self.personDetail.view setHidden:YES];
    
    self.agencyDetail = [[AgencyViewController alloc] init];
    [self.viewInstance addSubview:self.agencyDetail.view];
    [self.agencyDetail.view setHidden:YES];

    self.entryDetail = [[EntryViewController alloc] init];
    [self.viewInstance addSubview:self.entryDetail.view];
    [self.entryDetail.view setHidden:YES];

    self.clientDetail = [[ClientViewController alloc] init];
    [self.viewInstance addSubview:self.clientDetail.view];
    [self.clientDetail.view setHidden:YES];
    
    self.countryDetail = [[CountryViewController alloc] init];
    [self.viewInstance addSubview:self.countryDetail.view];
    [self.countryDetail.view setHidden:YES];

    self.groupDetail = [[GroupViewController alloc] init];
    [self.viewInstance addSubview:self.groupDetail.view];
    [self.groupDetail.view setHidden:YES];
    
    self.scoreModule = [[ScoreListViewController alloc] init];
    [self.viewInstance addSubview:self.scoreModule.view];
    [self.scoreModule.view setHidden:YES];

    self.dashboard = [[DashboardViewController alloc] init];
    [self.viewInstance addSubview:self.dashboard.view];    
    
    [self orientationChangedMethod];

    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
