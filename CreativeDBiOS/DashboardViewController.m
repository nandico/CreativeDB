//
//  DashboardViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "DashboardViewController.h"
#import "ClientEngine.h"
#import "DashboardView.h"

@interface DashboardViewController ()

@property (nonatomic, strong) ClientEngine *engine;
@property (strong, nonatomic) DashboardView *viewInstance;

@property (nonatomic) UIDeviceOrientation currentOrientation;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *entrySquares;

@end

@implementation DashboardViewController

- (id)init
{
    self = [super init];
    if (self) {
        _engine = [[ClientEngine alloc] init];
        _entrySquares = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) loadView
{
    self.view = self.viewInstance = [[DashboardView alloc] initWithFrame:CONTENT_LANDSCAPE_FRAME];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self scrollView];
    
    [self createSquares];
}

- (void) createSquares
{
    [_scrollView setContentSize:CGSizeMake(0.0f, 1200.0f) ];
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    _currentOrientation = orientation;
    
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
        
       [self.viewInstance updateOrientation:_currentOrientation];
        self.scrollView.frame = INNER_CONTENT_PORTRAIT_FRAME;
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        [self.viewInstance updateOrientation:_currentOrientation];
        self.scrollView.frame = INNER_CONTENT_LANDSCAPE_FRAME;
    }
    
}

- (UIScrollView *) scrollView
{
    if( !_scrollView )
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:INNER_CONTENT_LANDSCAPE_FRAME];
        [self.viewInstance addSubview:_scrollView];
        
    }
    
    [self.viewInstance addSubview:_scrollView];
    
    return _scrollView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
