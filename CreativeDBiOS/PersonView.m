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

@property (nonatomic, strong) NameLabel *name;
@property (nonatomic, strong) CountryLabel *country;
@property (nonatomic, strong) PositionLabel *position;
@property (nonatomic, strong) ScoreLabel *score;
@property (nonatomic, strong) CountryImageView *flag;
@property (strong, nonatomic) BaseView *background;

@end

@implementation PersonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        NSLog( @"Adding elements" );
        
        [self background];
        [self name];
        [self country];
        [self position];
        [self score];
        [self flag];
        
        self.name.text = @"Fulano de tal";
        self.country.text = @"Brasil";
        self.position.text = @"1st";
        self.score.text = @"290pts";
        
        self.flag.image = [UIImage imageNamed:@"br.png"];
    }
    return self;
}

- (void) layoutSubviews
{
    NSLog( @"Layout subviews.." );
    
    CGRect contentRect = self.background.bounds;
    CGFloat boundsX = contentRect.origin.x;

    _name.frame = CGRectMake( boundsX + 140, LIST_OFFSET_Y + 10, 200, 50 );
    _country.frame = CGRectMake( boundsX + 160, LIST_OFFSET_Y + 70, 200, 50 );
    _position.frame = CGRectMake( boundsX + 10, LIST_OFFSET_Y + 20, 100, 50 );
    _score.frame = CGRectMake( boundsX + 400, LIST_OFFSET_Y + 20, 200, 50 );
    _flag.frame = CGRectMake( boundsX + 140, LIST_OFFSET_Y + 90, 16, 11 );
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

- (PositionLabel *) position
{
    if( !_position )
    {
        _position = [[PositionLabel alloc] init];
        [self addSubview:_position];
    }
    
    return _position;
}

- (ScoreLabel *) score
{
    if( !_score )
    {
        _score = [[ScoreLabel alloc] init];
        [self addSubview:_score];
    }
    
    return _score;
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
