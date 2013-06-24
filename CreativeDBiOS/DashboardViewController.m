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
#import "DashboardSquare.h"
#import "EntryModel.h"
#import "PersonModel.h"
#import "AgencyModel.h"

@interface DashboardViewController ()

@property (nonatomic, strong) ClientEngine *engine;
@property (strong, nonatomic) DashboardView *viewInstance;

@property (nonatomic) UIDeviceOrientation currentOrientation;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *entrySquares;


@property (strong, nonatomic) DashboardSquare *entriesSummary;
@property (strong, nonatomic) DashboardSquare *personSummary;
@property (strong, nonatomic) DashboardSquare *agencySummary;

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

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self arrangeSquares];
}

- (void) createSquares
{
    _entriesSummary = [[DashboardSquare alloc] init];
    _entriesSummary.backgroundColor = [UIColor orangeColor];
    [self.scrollView addSubview:_entriesSummary];
    
    _entriesSummary.title.text = [[EntryModel modelCount] stringValue];
    _entriesSummary.content.text = @"Entries";

    _personSummary = [[DashboardSquare alloc] init];
    _personSummary.backgroundColor = [UIColor blueColor];
    [self.scrollView addSubview:_personSummary];
    
    _personSummary.title.text = [[PersonModel modelCount] stringValue];
    _personSummary.content.text = @"People";
    
    _agencySummary = [[DashboardSquare alloc] init];
    _agencySummary.backgroundColor = [UIColor brownColor];
    [self.scrollView addSubview:_agencySummary];
    
    _agencySummary.title.text = [[AgencyModel modelCount] stringValue];
    _agencySummary.content.text = @"Agencies";
    
}

- (void) arrangeSquares
{
    [_engine startEngine];
    [_engine setMustConsiderHeader:NO];
    [_engine setSpacingAfterHeader:0.0f];
    
    [_engine setCurrentOrientation:_currentOrientation];
    
    ColumnModel *columnSquare = [[ColumnModel alloc] initWithFixed:@250];
    ColumnModel *columnImage = [[ColumnModel alloc] initWithFixed:@250];
    ColumnModel *column100 = [[ColumnModel alloc] initWithPercent:@100];
    
    LineModel *line1 = [[LineModel alloc] initWithOptions:
                       [NSMutableArray arrayWithObjects:columnSquare, column100, nil ]];
    line1.height = @250;
    [_engine addLine:line1];
    
    [_engine applyFrame:_entriesSummary withLine:line1 andColumn:columnSquare];
    
    LineModel *line2 = [[LineModel alloc] initWithOptions:
                        [NSMutableArray arrayWithObjects:columnImage, columnSquare, column100, nil ]];
    line2.height = @250;
    [_engine addLine:line2];
    
    [_engine applyFrame:_personSummary withLine:line2 andColumn:columnSquare];
    
    LineModel *line3 = [[LineModel alloc] initWithOptions:
                        [NSMutableArray arrayWithObjects:columnSquare, column100, nil ]];
    line3.height = @250;
    [_engine addLine:line3];
    
    [_engine applyFrame:_agencySummary withLine:line3 andColumn:columnSquare];
    
    [_scrollView setContentSize:CGSizeMake(0.0f, 1200.0f) ];
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    _currentOrientation = orientation;
    
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
       [self.viewInstance updateOrientation:_currentOrientation];
        self.scrollView.frame = INNER_CONTENT_PORTRAIT_FRAME;
        [self arrangeSquares];
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        [self.viewInstance updateOrientation:_currentOrientation];
        self.scrollView.frame = INNER_CONTENT_LANDSCAPE_FRAME;
        [self arrangeSquares];
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
