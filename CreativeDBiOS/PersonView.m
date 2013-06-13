//
//  PersonView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/12/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonView.h"
#import "NameLabel.h"
#import "CountryLabel.h"
#import "PositionLabel.h"
#import "ScoreLabel.h"
#import "CountryImageView.h"
#import "BaseView.h"
#import "ClientEngine.h"
#import "H1Label.h"
#import "H4Label.h"
#import "EntryDetailView.h"
#import "AwardModel.h"

@interface PersonView()

@property (nonatomic) UIDeviceOrientation currentOrientation;

@property (nonatomic, strong) NameLabel *name;
@property (nonatomic, strong) CountryLabel *country;
@property (nonatomic, strong) CountryImageView *flag;
@property (strong, nonatomic) BaseView *background;

@property (nonatomic, strong) H4Label *globalStats;
@property (nonatomic, strong) ScoreLabel *globalScore;
@property (nonatomic, strong) H4Label *countryStats;
@property (nonatomic, strong) ScoreLabel *countryScore;

@property (nonatomic, strong) H1Label *titleEntries;

@property (nonatomic, strong) NSMutableArray *entryLines;

@end

@implementation PersonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];

        [self background];
        [self name];
        [self country];
        [self flag];
        
        [self globalStats];
        [self globalScore];
        [self countryStats];
        [self countryScore];
        
        [self titleEntries];

   }
    return self;
}

- (void) updateData
{
    PersonModel *selectedPerson = [self.dataSource selectedPerson];
 
    self.name.text = selectedPerson.name;
    self.country.text = selectedPerson.country.name;
    self.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [selectedPerson.country.iso lowercaseString] ]];
    
    self.globalStats.text = @"GLOBAL";
    self.globalScore.text = @"256th";
    
    self.countryStats.text = @"COUNTRY";
    self.countryScore.text = @"22th";
    
    self.titleEntries.text = @"Entries";
    
    NSInteger awardIndex = 0;
    
    for( EntryModel *entry in selectedPerson.entries )
    {
        for( AwardModel *award in entry.awards )
        {
            EntryDetailView *entryView = [[EntryDetailView alloc] initWithFrame:CGRectMake(0, LIST_OFFSET_Y + 250.0f + (awardIndex * 300.0), 1024.0, 300.0f)];
            [entryView updateData];
            [self addSubview:entryView];
        
            awardIndex ++;
        }
    }

}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
        self.background.frame = LIST_PORTRAIT_FRAME ;
        _currentOrientation = orientation;
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        self.background.frame = LIST_LANDSCAPE_FRAME;
        _currentOrientation = orientation;
    }
}

- (void) layoutSubviews
{
    CGRect contentRect = self.background.bounds;
    CGFloat boundsX = contentRect.origin.x;

    _name.frame = CGRectMake( boundsX + 30, LIST_OFFSET_Y + 10, 200, 50 );
    _country.frame = CGRectMake( boundsX + 50, LIST_OFFSET_Y + 50, 200, 50 );
    _flag.frame = CGRectMake( boundsX + 30, LIST_OFFSET_Y + 70, 16, 11 );
    
    _globalStats.frame = CGRectMake( boundsX + 450, LIST_OFFSET_Y + 2, 200, 50 );
    _globalScore.frame = CGRectMake( boundsX + 450, LIST_OFFSET_Y + 40, 200, 50 );
    
    _countryStats.frame = CGRectMake( boundsX + 650, LIST_OFFSET_Y + 2, 200, 50 );
    _countryScore.frame = CGRectMake( boundsX + 650, LIST_OFFSET_Y + 40, 200, 50 );

    _titleEntries.frame = CGRectMake( boundsX + 30, LIST_OFFSET_Y + 200, 200, 50 );
}


- (BaseView *) background
{
    if( !_background )
    {
        _background = [[BaseView alloc] initWithFrame:LIST_LANDSCAPE_FRAME];
        _background.backgroundColor = [UIColor whiteColor];
        [self addSubview:_background];
    }
    
    return _background;
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

- (H1Label *) titleEntries
{
    if( !_titleEntries )
    {
        _titleEntries = [[H1Label alloc] init];
        [self addSubview:_titleEntries];
    }
    
    return _titleEntries;
}

@end
