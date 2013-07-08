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


@property (strong, nonatomic) DashboardSquare *wonBlock;
@property (strong, nonatomic) DashboardSquare *coveringBlock;
@property (strong, nonatomic) DashboardSquare *rewardingBlock;
@property (strong, nonatomic) DashboardSquare *fromBlock;
@property (strong, nonatomic) DashboardSquare *andBlock;
@property (strong, nonatomic) DashboardSquare *forBlock;
@property (strong, nonatomic) DashboardSquare *ofBlock;

@property (strong, nonatomic) DashboardSquare *thisBlock;
@property (strong, nonatomic) DashboardSquare *isBlock;
@property (strong, nonatomic) DashboardSquare *creativeDBBlock;

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
    UIColor *baseBackgroundColor = PALLETE_WHITE_FOR_BACKGROUND;
    UIColor *baseTextColor = PALLETE_BLACK_FOR_ELEMENTS;
    
    _entriesSummary = [[DashboardSquare alloc] init];
    _entriesSummary.backgroundColor = PALLETE_BASE_COLOR_A;
    [self.scrollView addSubview:_entriesSummary];
    _entriesSummary.title.text = [[EntryModel modelCount] stringValue];
    _entriesSummary.content.text = @"Entries";
    
    _wonBlock = [[DashboardSquare alloc] init];
    _wonBlock.backgroundColor = baseBackgroundColor;
    [self.scrollView addSubview:_wonBlock];
    _wonBlock.title.font = LABEL_BIG_FONT;
    _wonBlock.title.text = @"WON";
    _wonBlock.title.textColor = baseTextColor;

    _awardsSummary = [[DashboardSquare alloc] init];
    _awardsSummary.backgroundColor = PALLETE_BASE_COLOR_H;
    [self.scrollView addSubview:_awardsSummary];
    _awardsSummary.title.text = [[AwardModel modelCount] stringValue];
    _awardsSummary.content.text = @"Awards";

    _coveringBlock = [[DashboardSquare alloc] init];
    _coveringBlock.backgroundColor = baseBackgroundColor;
    [self.scrollView addSubview:_coveringBlock];
    _coveringBlock.title.font = LABEL_BIG_FONT;
    _coveringBlock.title.text = @"COVERING";
    _coveringBlock.title.textColor = baseTextColor;
    
    _festivalSummary = [[DashboardSquare alloc] init];
    _festivalSummary.backgroundColor = PALLETE_BASE_COLOR_C;
    [self.scrollView addSubview:_festivalSummary];
    _festivalSummary.title.text = [NSString stringWithFormat:@"%@ of %@", [[FestivalModel modelActiveCount] stringValue], [[FestivalModel modelCount] stringValue] ];
    _festivalSummary.content.text = @"Festivals";
    
    _rewardingBlock = [[DashboardSquare alloc] init];
    _rewardingBlock.backgroundColor = baseBackgroundColor;
    [self.scrollView addSubview:_rewardingBlock];
    _rewardingBlock.title.font = LABEL_BIG_FONT;
    _rewardingBlock.title.text = @"REWARDING";
    _rewardingBlock.title.textColor = baseTextColor;
    
    _personSummary = [[DashboardSquare alloc] init];
    _personSummary.backgroundColor = PALLETE_BASE_COLOR_D;
    [self.scrollView addSubview:_personSummary];
    _personSummary.title.text = [[PersonModel modelCount] stringValue];
    _personSummary.content.text = @"People";
    
    _fromBlock = [[DashboardSquare alloc] init];
    _fromBlock.backgroundColor = baseBackgroundColor;
    [self.scrollView addSubview:_fromBlock];
    _fromBlock.title.font = LABEL_BIG_FONT;
    _fromBlock.title.text = @"FROM";
    _fromBlock.title.textColor = baseTextColor;
    
    _agencySummary = [[DashboardSquare alloc] init];
    _agencySummary.backgroundColor = PALLETE_BASE_COLOR_E;
    [self.scrollView addSubview:_agencySummary];
    _agencySummary.title.text = [[AgencyModel modelCount] stringValue];
    _agencySummary.content.text = @"Agencies";
    
    _groupSummary = [[DashboardSquare alloc] init];
    _groupSummary.backgroundColor = PALLETE_BASE_COLOR_F;
    [self.scrollView addSubview:_groupSummary];
    _groupSummary.title.text = [[GroupModel modelActiveCount] stringValue];
    _groupSummary.content.text = @"Groups";
    
    _producerSummary = [[DashboardSquare alloc] init];
    _producerSummary.backgroundColor = PALLETE_BASE_COLOR_D;
    [self.scrollView addSubview:_producerSummary];
    _producerSummary.title.text = [[ProducerModel modelCount] stringValue];
    _producerSummary.content.text = @"Producer companies";
    
    _forBlock = [[DashboardSquare alloc] init];
    _forBlock.backgroundColor = baseBackgroundColor;
    [self.scrollView addSubview:_forBlock];
    _forBlock.title.font = LABEL_BIG_FONT;
    _forBlock.title.text = @"FOR";
    _forBlock.title.textColor = baseTextColor;
    
    _clientSummary = [[DashboardSquare alloc] init];
    _clientSummary.backgroundColor = PALLETE_BASE_COLOR_H;
    [self.scrollView addSubview:_clientSummary];
    _clientSummary.title.text = [[ClientModel modelCount] stringValue];
    _clientSummary.content.text = @"Clients";
    
    _andBlock = [[DashboardSquare alloc] init];
    _andBlock.backgroundColor = baseBackgroundColor;
    [self.scrollView addSubview:_andBlock];
    _andBlock.title.font = LABEL_BIG_FONT;
    _andBlock.title.text = @"AND";
    _andBlock.title.textColor = baseTextColor;
    
    _productSummary = [[DashboardSquare alloc] init];
    _productSummary.backgroundColor = PALLETE_BASE_COLOR_G;
    [self.scrollView addSubview:_productSummary];
    _productSummary.title.text = [[ProductModel modelCount] stringValue];
    _productSummary.content.text = @"Products";
    
    _ofBlock = [[DashboardSquare alloc] init];
    _ofBlock.backgroundColor = baseBackgroundColor;
    [self.scrollView addSubview:_ofBlock];
    _ofBlock.title.font = LABEL_BIG_FONT;
    _ofBlock.title.text = @"OF";
    _ofBlock.title.textColor = baseTextColor;

    _countrySummary = [[DashboardSquare alloc] init];
    _countrySummary.backgroundColor = PALLETE_BASE_COLOR_J;
    [self.scrollView addSubview:_countrySummary];
    _countrySummary.title.text = [[CountryModel modelActiveCount] stringValue];
    _countrySummary.content.text = @"Countries";
    
    _thisBlock = [[DashboardSquare alloc] init];
    _thisBlock.backgroundColor = baseBackgroundColor;
    [self.scrollView addSubview:_thisBlock];
    _thisBlock.title.font = LABEL_BIG_FONT;
    _thisBlock.title.text = @"THIS";
    _thisBlock.title.textColor = baseTextColor;
    
    _isBlock = [[DashboardSquare alloc] init];
    _isBlock.backgroundColor = PALLETE_BASE_COLOR_A;
    [self.scrollView addSubview:_isBlock];
    _isBlock.title.font = LABEL_BIG_FONT;
    _isBlock.title.text = @"IS";
    _isBlock.title.textColor = baseBackgroundColor;
    
    _creativeDBBlock = [[DashboardSquare alloc] init];
    _creativeDBBlock.backgroundColor = PALLETE_BASE_COLOR_B;
    [self.scrollView addSubview:_creativeDBBlock];
    _creativeDBBlock.title.font = LABEL_BIG_FONT;
    _creativeDBBlock.title.text = @"CreativeDB";
    _creativeDBBlock.title.textColor = PALLETE_WHITE_FOR_ELEMENTS;
    
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
    ColumnModel *columnImage3 = [[ColumnModel alloc] initWithFixed:@250];
    
    LineModel *line1 = [[LineModel alloc] initWithOptions:
                       [NSMutableArray arrayWithObjects:columnSquare1, columnImage1, columnSquare2, columnImage2, columnSquare3, nil ]];
    line1.height = @250;
    [_engine addLine:line1];
    
    [_engine applyFrame:_entriesSummary withLine:line1 andColumn:columnSquare1];
    [_engine applyFrame:_wonBlock withLine:line1 andColumn:columnImage1];
    [_engine applyFrame:_awardsSummary withLine:line1 andColumn:columnSquare2];
    [_engine applyFrame:_coveringBlock withLine:line1 andColumn:columnImage2];
    [_engine applyFrame:_festivalSummary withLine:line1 andColumn:columnSquare3];
    
    LineModel *line2 = [[LineModel alloc] initWithOptions:
                        [NSMutableArray arrayWithObjects:columnImage1, columnSquare1, columnImage2, columnSquare2, columnImage3, nil ]];
    line2.height = @250;
    [_engine addLine:line2];
    
    [_engine applyFrame:_rewardingBlock withLine:line2 andColumn:columnImage1];
    [_engine applyFrame:_personSummary withLine:line2 andColumn:columnSquare1];
    [_engine applyFrame:_fromBlock withLine:line2 andColumn:columnImage2];
    [_engine applyFrame:_agencySummary withLine:line2 andColumn:columnSquare2];
    [_engine applyFrame:_groupSummary withLine:line2 andColumn:columnImage3];
    
    LineModel *line3 = [[LineModel alloc] initWithOptions:
                        [NSMutableArray arrayWithObjects:columnSquare1, columnImage1, columnSquare2, columnImage2, columnSquare3, nil ]];
    line3.height = @250;
    [_engine addLine:line3];
    
    [_engine applyFrame:_producerSummary withLine:line3 andColumn:columnSquare1];
    [_engine applyFrame:_forBlock withLine:line3 andColumn:columnImage1];
    [_engine applyFrame:_clientSummary withLine:line3 andColumn:columnSquare2];
    [_engine applyFrame:_andBlock withLine:line3 andColumn:columnImage2];
    [_engine applyFrame:_productSummary withLine:line3 andColumn:columnSquare3];
    
    LineModel *line4 = [[LineModel alloc] initWithOptions:
                        [NSMutableArray arrayWithObjects:columnImage1, columnSquare1, columnImage2, columnSquare2, nil ]];
    line4.height = @250;
    [_engine addLine:line4];
    
    [_engine applyFrame:_ofBlock withLine:line4 andColumn:columnImage1];
    [_engine applyFrame:_countrySummary withLine:line4 andColumn:columnSquare1];
    [_engine applyFrame:_thisBlock withLine:line4 andColumn:columnImage2];
    [_engine applyFrame:_isBlock withLine:line4 andColumn:columnSquare2];
    [_engine applyFrame:_creativeDBBlock withLine:line4 andColumn:columnImage3];

    
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
