//
//  ProducerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProducerView.h"
#import "PersonIdView.h"
#import "NameLabel.h"
#import "CountryLabel.h"
#import "CountryImageView.h"
#import "BaseView.h"

#import "H4Label.h"
#import "ScoreLabel.h"

@interface ProducerView()

@property (nonatomic) UIDeviceOrientation currentOrientation;

@property (nonatomic, strong) PersonIdView *thumb;
@property (nonatomic, strong) NameLabel *name;
@property (nonatomic, strong) CountryLabel *country;
@property (nonatomic, strong) CountryImageView *flag;
@property (strong, nonatomic) BaseView *background;

@property (nonatomic, strong) H4Label *globalStats;
@property (nonatomic, strong) ScoreLabel *globalScore;
@property (nonatomic, strong) H4Label *countryStats;
@property (nonatomic, strong) ScoreLabel *countryScore;

@property (nonatomic, strong) ClientEngine *engine;


@end

@implementation ProducerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = PALLETE_WHITE_FOR_BACKGROUND;
        
        [self background];
        [self thumb];
        [self name];
        [self country];
        [self flag];
        
        [self globalStats];
        [self globalScore];
        [self countryStats];
        [self countryScore];
        
        _engine = [[ClientEngine alloc] init];
        
    }
    return self;
}


-(NSString *) addSuffixToNumber:( long ) number
{
    NSString *suffix;
    int ones = number % 10;
    int temp = floor(number/10.0);
    int tens = temp%10;
    
    if (tens ==1) {
        suffix = @"th";
    } else if (ones ==1){
        suffix = @"st";
    } else if (ones ==2){
        suffix = @"nd";
    } else if (ones ==3){
        suffix = @"rd";
    } else {
        suffix = @"th";
    }
    
    NSString *completeAsString = [NSString stringWithFormat:@"%ld%@",number,suffix];
    return completeAsString;
}

- (void) updateData
{
    ProducerModel *selectedProducer = [self.dataSource selectedProducer];
    
    if( !selectedProducer ) return;
    
    self.thumb.userInitials.text = [self.thumb extractInitials:selectedProducer.name];
    self.name.text = selectedProducer.name;
    self.country.text = selectedProducer.country.name;
    self.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [selectedProducer.country.iso lowercaseString] ]];
    
    self.globalStats.text = @"GLOBAL";
    self.globalScore.text = [NSString stringWithFormat:@"%@", [self addSuffixToNumber:[selectedProducer.rankingGlobal longValue]]];
    
    self.countryStats.text = @"COUNTRY";
    self.countryScore.text = [NSString stringWithFormat:@"%@", [self addSuffixToNumber:[selectedProducer.rankingCountry longValue]]];
    
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
        self.background.frame = INNER_CONTENT_PORTRAIT_FRAME;
        _currentOrientation = orientation;
        [_engine setCurrentOrientation:_currentOrientation];
        
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        self.background.frame = INNER_CONTENT_LANDSCAPE_FRAME;
        _currentOrientation = orientation;
        [_engine setCurrentOrientation:_currentOrientation];
        
    }
}


- (void) layoutSubviews
{
    [_engine startEngine];
    [_engine setMustConsiderHeader:NO];
    [_engine setSpacingAfterHeader:0.0f];
    [_engine setCurrentOrientation:_currentOrientation];
    
    ColumnModel *column1 = [[ColumnModel alloc] initWithPercent:@42];
    ColumnModel *column2 = [[ColumnModel alloc] initWithPercent:@29];
    ColumnModel *column3 = [[ColumnModel alloc] initWithPercent:@29];
    ColumnModel *column4 = [[ColumnModel alloc] initWithFixed:@125];
    
    CGFloat rankingOffsetY = 10.0f;
    
    LineModel *line1 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column1, column2, column3, column4, nil]];
    line1.height = @125;
    [_engine addLine:line1];
    
    _name.prefferedHeight = 50.0f;
    _name.offsetX = APP_LEFT_PADDING;
    _name.offsetY = 10.0f + rankingOffsetY;
    
    [_engine applyFrame:_name withLine:line1 andColumn:column1];
    
    _country.prefferedHeight = 50.0f;
    _country.offsetX = 56.0f;
    _country.offsetY = 48.0f + rankingOffsetY;
    
    [_engine applyFrame:_country withLine:line1 andColumn:column1];
    
    _flag.prefferedWidth = 16.0f;
    _flag.prefferedHeight = 11.0f;
    _flag.offsetX = APP_LEFT_PADDING;
    _flag.offsetY = 67.0f + rankingOffsetY;
    
    [_engine applyFrame:_flag withLine:line1 andColumn:column1];
    
    _globalStats.prefferedHeight = 50.0f;
    _globalStats.offsetX = 0.0f;
    _globalStats.offsetY = 3.0f + rankingOffsetY;
    
    [_engine applyFrame:_globalStats withLine:line1 andColumn:column2];
    
    _globalScore.prefferedHeight = 50.0f;
    _globalScore.offsetX = 0.0f;
    _globalScore.offsetY = 38.0f + rankingOffsetY;
    
    [_engine applyFrame:_globalScore withLine:line1 andColumn:column2];
    
    _countryStats.prefferedHeight = 50.0f;
    _countryStats.offsetX = 0.0f;
    _countryStats.offsetY = 3.0f + rankingOffsetY;
    
    [_engine applyFrame:_countryStats withLine:line1 andColumn:column3];
    
    _countryScore.prefferedHeight = 50.0f;
    _countryScore.offsetX = 0.0f;
    _countryScore.offsetY = 38.0f + rankingOffsetY;
    
    [_engine applyFrame:_countryScore withLine:line1 andColumn:column3];
    
    _thumb.prefferedWidth = 128.0f;
    _thumb.prefferedHeight = 125.0f;
    
    [_engine applyFrame:_thumb withLine:line1 andColumn:column4];
    
    column1 = [[ColumnModel alloc] initWithPercent:@100];
    LineModel *line2 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column1, nil]];
    line2.height = @80.0;
    [_engine addLine:line2];
    
}


- (BaseView *) background
{
    if( !_background )
    {
        _background = [[BaseView alloc] init];
        _background.backgroundColor = PALLETE_WHITE_FOR_BACKGROUND;
        [self addSubview:_background];
    }
    
    return _background;
}

- (PersonIdView *) thumb
{
    if( !_thumb )
    {
        _thumb = [[PersonIdView alloc] init];
        [self addSubview:_thumb];
    }
    
    return _thumb;
}

- (NameLabel *) name
{
    if( !_name )
    {
        _name = [[NameLabel alloc] init];
        [self addSubview:_name];
    }
    
    return _name;
}

- (CountryLabel *) country
{
    if( !_country )
    {
        _country = [[CountryLabel alloc] init];
        [self addSubview:_country];
    }
    
    return _country;
}

- (CountryImageView *) flag
{
    if( !_flag )
    {
        _flag = [[CountryImageView alloc] init];
        [self addSubview:_flag];
    }
    
    return _flag;
}

- (H4Label *) globalStats
{
    if( !_globalStats )
    {
        _globalStats = [[H4Label alloc] init];
        [self addSubview:_globalStats];
    }
    
    return _globalStats;
}

- (ScoreLabel *) globalScore
{
    if( !_globalScore )
    {
        _globalScore = [[ScoreLabel alloc] init];
        [self addSubview:_globalScore];
    }
    
    return _globalScore;
}

- (H4Label *) countryStats
{
    if( !_countryStats )
    {
        _countryStats = [[H4Label alloc] init];
        [self addSubview:_countryStats];
    }
    
    return _countryStats;
}

- (ScoreLabel *) countryScore
{
    if( !_countryScore )
    {
        _countryScore = [[ScoreLabel alloc] init];
        [self addSubview:_countryScore];
    }
    
    return _countryScore;
}


@end
