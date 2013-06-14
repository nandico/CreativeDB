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
#import "AwardModel.h"
#import "LineModel.h"
#import "ColumnModel.h"

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
    
    if( !selectedPerson ) return;
 
    self.name.text = selectedPerson.name;
    self.country.text = selectedPerson.country.name;
    self.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [selectedPerson.country.iso lowercaseString] ]];
    
    self.globalStats.text = @"GLOBAL";
    self.globalScore.text = @"256th";
    
    self.countryStats.text = @"COUNTRY";
    self.countryScore.text = @"22th";
    
    self.titleEntries.text = @"Entries";
    
    NSInteger awardIndex = 0;
    
    _entryLines = [[NSMutableArray alloc] init];
    
    LineModel *line;
    ColumnModel *column;
    
    [self layoutSubviews];
    
    for( EntryModel *entry in selectedPerson.entries )
    {
        for( AwardModel *award in entry.awards )
        {
            column = [[ColumnModel alloc] initWithPercent:@100];
            line = [[LineModel alloc] initWithOptions:
                    [NSMutableArray arrayWithObjects:column, nil ]];
            line.height = @180;
            [ClientEngine addLine:line];
            
            EntryDetailView *entryView = [[EntryDetailView alloc] init];
            
            [ClientEngine applyFrame:entryView withLine:line andColumn:column];
            
            entryView.selectedEntry = entry;
            entryView.selectedAward = award;
            [entryView updateData];
            [self addSubview:entryView];
            
            [_entryLines addObject:entryView];
        
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
        [ClientEngine setCurrentOrientation:_currentOrientation];
        
        [self updateChildOrientation:orientation];
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        self.background.frame = LIST_LANDSCAPE_FRAME;
        _currentOrientation = orientation;
        [ClientEngine setCurrentOrientation:_currentOrientation];
        
        [self updateChildOrientation:orientation];
    }
}

- (void) updateChildOrientation:( UIDeviceOrientation ) orientation
{
    for( EntryDetailView *child in _entryLines )
    {
        [child updateOrientation:orientation];
    }
}

- (void) layoutSubviews
{
    [ClientEngine startEngine];
    [ClientEngine setMustConsiderHeader:YES];
    [ClientEngine setCurrentOrientation:_currentOrientation];
    
    ColumnModel *column1 = [[ColumnModel alloc] initWithPercent:@40];
    ColumnModel *column2 = [[ColumnModel alloc] initWithPercent:@30];
    ColumnModel *column3 = [[ColumnModel alloc] initWithPercent:@30];

    LineModel *line1 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column1, column2, column3, nil]];
    line1.height = @120;
    [ClientEngine addLine:line1];
    
    _name.prefferedWidth = 200.0f;
    _name.prefferedHeight = 50.0f;
    _name.offsetX = 30.0f;
    _name.offsetY = 10.0f;
    
    [ClientEngine applyFrame:_name withLine:line1 andColumn:column1];
    
    _country.prefferedWidth = 200.0f;
    _country.prefferedHeight = 50.0f;
    _country.offsetX = 50.0f;
    _country.offsetY = 45.0f;
    
    [ClientEngine applyFrame:_country withLine:line1 andColumn:column1];
    
    _flag.prefferedWidth = 16.0f;
    _flag.prefferedHeight = 11.0f;
    _flag.offsetX = 30.0f;
    _flag.offsetY = 64.0f;
    
    [ClientEngine applyFrame:_flag withLine:line1 andColumn:column1];
    
    _globalStats.prefferedWidth = 200.0f;
    _globalStats.prefferedHeight = 50.0f;
    _globalStats.offsetX = 0.0f;
    _globalStats.offsetY = 3.0f;
    
    [ClientEngine applyFrame:_globalStats withLine:line1 andColumn:column2];
    
    _globalScore.prefferedWidth = 200.0f;
    _globalScore.prefferedHeight = 50.0f;
    _globalScore.offsetX = 0.0f;
    _globalScore.offsetY = 35.0f;
    
    [ClientEngine applyFrame:_globalScore withLine:line1 andColumn:column2];
    
    _countryStats.prefferedWidth = 200.0f;
    _countryStats.prefferedHeight = 50.0f;
    _countryStats.offsetX = 0.0f;
    _countryStats.offsetY = 3.0f;
    
    [ClientEngine applyFrame:_countryStats withLine:line1 andColumn:column3];
    
    _countryScore.prefferedWidth = 200.0f;
    _countryScore.prefferedHeight = 50.0f;
    _countryScore.offsetX = 0.0f;
    _countryScore.offsetY = 35.0f;
    
    [ClientEngine applyFrame:_countryScore withLine:line1 andColumn:column3];
    
    
    column1 = [[ColumnModel alloc] initWithPercent:@100];
    LineModel *line2 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column1, nil]];
    line2.height = @80.0;
    [ClientEngine addLine:line2];

    _titleEntries.prefferedWidth = 200.0f;
    _titleEntries.prefferedHeight = 50.0f;
    _titleEntries.offsetX = 30.0f;
    _titleEntries.offsetY = 0.0f;
    
    [ClientEngine applyFrame:_titleEntries withLine:line2 andColumn:column1];
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
