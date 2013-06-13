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

@interface PersonView()

@property (nonatomic) UIDeviceOrientation currentOrientation;

@property (nonatomic, strong) NameLabel *name;
@property (nonatomic, strong) CountryLabel *country;
@property (nonatomic, strong) CountryImageView *flag;
@property (strong, nonatomic) BaseView *background;

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
        
        /*
         Nome
         (Bandeira / Pais)
         
         Ranking
         
         Global
         Into Country
         Into Agency
         Into Group
  
         
         
         
         */
        
   }
    return self;
}

- (void) updateData
{
    PersonModel *selectedPerson = [self.dataSource selectedPerson];
 
    self.name.text = selectedPerson.name;
    self.country.text = selectedPerson.country.name;
    self.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [selectedPerson.country.iso lowercaseString] ]];
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

@end
