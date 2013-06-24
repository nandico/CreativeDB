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
#import "AwardModel.h"
#import "CountryModel.h"
#import "ProducerModel.h"

@interface DashboardViewController ()

@property (nonatomic, strong) ClientEngine *engine;
@property (strong, nonatomic) DashboardView *viewInstance;

@property (nonatomic) UIDeviceOrientation currentOrientation;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *entrySquares;


@property (strong, nonatomic) DashboardSquare *entriesSummary;
@property (strong, nonatomic) DashboardSquare *personSummary;
@property (strong, nonatomic) DashboardSquare *agencySummary;
@property (strong, nonatomic) DashboardSquare *awardsSummary;
@property (strong, nonatomic) DashboardSquare *countrySummary;
@property (strong, nonatomic) DashboardSquare *producerSummary;
@property (strong, nonatomic) DashboardSquare *clientSummary;
@property (strong, nonatomic) DashboardSquare *groupSummary;
@property (strong, nonatomic) DashboardSquare *festivalSummary;
@property (strong, nonatomic) DashboardSquare *productSummary;

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

    _awardsSummary = [[DashboardSquare alloc] init];
    _awardsSummary.backgroundColor = [UIColor yellowColor];
    [self.scrollView addSubview:_awardsSummary];
    _awardsSummary.title.text = [[AwardModel modelCount] stringValue];
    _awardsSummary.content.text = @"Awards";
    _awardsSummary.title.textColor = [UIColor blackColor];
    _awardsSummary.content.textColor = [UIColor blackColor];
    
    _countrySummary = [[DashboardSquare alloc] init];
    _countrySummary.backgroundColor = [UIColor magentaColor];
    [self.scrollView addSubview:_countrySummary];
    _countrySummary.title.text = [[CountryModel modelCount] stringValue];
    _countrySummary.content.text = @"Countries";

    
    _producerSummary = [[DashboardSquare alloc] init];
    _producerSummary.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:_producerSummary];
    _producerSummary.title.text = [[ProducerModel modelCount] stringValue];
    _producerSummary.content.text = @"Producer companies";

    
    _festivalSummary = [[DashboardSquare alloc] init];
    _festivalSummary.backgroundColor = [UIColor cyanColor];
    [self.scrollView addSubview:_festivalSummary];
    _festivalSummary.title.text = [[FestivalModel modelActiveCount] stringValue];
    _festivalSummary.content.text = @"Festivals";
    _festivalSummary.title.textColor = [UIColor blackColor];
    _festivalSummary.content.textColor = [UIColor blackColor];
    
    _clientSummary = [[DashboardSquare alloc] init];
    _clientSummary.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:_clientSummary];
    _clientSummary.title.text = [[ClientModel modelCount] stringValue];
    _clientSummary.content.text = @"Clients";
    
    _groupSummary = [[DashboardSquare alloc] init];
    _groupSummary.backgroundColor = [UIColor purpleColor];
    [self.scrollView addSubview:_groupSummary];
    _groupSummary.title.text = [[GroupModel modelActiveCount] stringValue];
    _groupSummary.content.text = @"Groups";

    _productSummary = [[DashboardSquare alloc] init];
    _productSummary.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:_productSummary];
    _productSummary.title.text = [[ProductModel modelCount] stringValue];
    _productSummary.content.text = @"Products";

    
}

- (void) arrangeSquares
{
    [_engine startEngine];
    [_engine setMustConsiderHeader:NO];
    [_engine setSpacingAfterHeader:0.0f];
    
    [_engine setCurrentOrientation:_currentOrientation];
    
    ColumnModel *columnSquare1 = [[ColumnModel alloc] initWithFixed:@250];
    ColumnModel *columnSquare2 = [[ColumnModel alloc] initWithFixed:@250];
    ColumnModel *columnSquare3 = [[ColumnModel alloc] initWithFixed:@250];
    ColumnModel *columnImage1 = [[ColumnModel alloc] initWithFixed:@250];
    ColumnModel *columnImage2 = [[ColumnModel alloc] initWithFixed:@250];
    ColumnModel *column100 = [[ColumnModel alloc] initWithPercent:@100];
    
    LineModel *line1 = [[LineModel alloc] initWithOptions:
                       [NSMutableArray arrayWithObjects:columnSquare1, columnImage1, columnSquare2, columnImage2, columnSquare3, nil ]];
    line1.height = @250;
    [_engine addLine:line1];
    
    [_engine applyFrame:_entriesSummary withLine:line1 andColumn:columnSquare1];
    
    [_engine applyFrame:_awardsSummary withLine:line1 andColumn:columnSquare2];
    
    [_engine applyFrame:_festivalSummary withLine:line1 andColumn:columnSquare3];
    
    LineModel *line2 = [[LineModel alloc] initWithOptions:
                        [NSMutableArray arrayWithObjects:columnImage1, columnSquare1, columnImage2, columnSquare2, column100, nil ]];
    line2.height = @250;
    [_engine addLine:line2];
    
    [_engine applyFrame:_personSummary withLine:line2 andColumn:columnSquare1];
    [_engine applyFrame:_producerSummary withLine:line2 andColumn:columnSquare2];
    
    LineModel *line3 = [[LineModel alloc] initWithOptions:
                        [NSMutableArray arrayWithObjects:columnSquare1, columnImage1, columnSquare2, columnImage2, columnSquare3, nil ]];
    line3.height = @250;
    [_engine addLine:line3];
    
    [_engine applyFrame:_agencySummary withLine:line3 andColumn:columnSquare1];
    [_engine applyFrame:_countrySummary withLine:line3 andColumn:columnSquare2];
    [_engine applyFrame:_groupSummary withLine:line3 andColumn:columnSquare3];
    
    LineModel *line4 = [[LineModel alloc] initWithOptions:
                        [NSMutableArray arrayWithObjects:columnImage1, columnSquare1, columnImage2, columnSquare2, nil ]];
    line4.height = @250;
    [_engine addLine:line4];
    
    [_engine applyFrame:_clientSummary withLine:line4 andColumn:columnSquare1];
    [_engine applyFrame:_productSummary withLine:line4 andColumn:columnSquare2];
    
    [_scrollView setContentSize:CGSizeMake(250.0f * 5.0f, 250.0 * 4.0f) ];
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    _currentOrientation = orientation;
    
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
       [self.viewInstance updateOrientation:_currentOrientation];
        self.scrollView.frame = DASHBOARD_CONTENT_PORTRAIT_FRAME;
        [self arrangeSquares];
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        [self.viewInstance updateOrientation:_currentOrientation];
        self.scrollView.frame = DASHBOARD_CONTENT_LANDSCAPE_FRAME;
        [self arrangeSquares];
    }
    
}

- (UIScrollView *) scrollView
{
    if( !_scrollView )
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:DASHBOARD_CONTENT_LANDSCAPE_FRAME];
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
