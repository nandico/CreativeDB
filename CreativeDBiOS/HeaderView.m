//
//  HeaderView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "HeaderView.h"
#import "HeaderLabel.h"
#import "ClientEngine.h"
#import "PersonIdView.h"
#import "ClientEngine.h"

@interface HeaderView()

@property (strong, nonatomic) HeaderLabel *title;
@property (strong, nonatomic) BaseButton *scoreButton;
@property (strong, nonatomic) PersonIdView *logo;

@property (nonatomic) UIDeviceOrientation currentOrientation;

@end

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:HEADER_BACKGROUND_COLOR];
        [self title];
        [self logo];
        [self scoreButton];
    }
    return self;
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation
{
    _currentOrientation = orientation;
    
    [self layoutSubviews];
}

- (HeaderLabel *) title
{
    if(!_title)
    {
        _title = [[HeaderLabel alloc] init];
        [_title setText:APP_NAME];
        [self addSubview:_title];
    }
    
    return _title;
}

- (PersonIdView *) logo
{
    if(!_logo)
    {
        _logo = [[PersonIdView alloc] init];
        [self addSubview:_logo];
    }
    
    return _logo;
}

- (BaseButton *) scoreButton
{
    if( !_scoreButton )
    {
        _scoreButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        [_scoreButton setTitle:@"Score" forState:UIControlStateNormal];
        _scoreButton.titleLabel.font = MENU_BUTTON_FONT;
        _scoreButton.titleLabel.textColor = MENU_BUTTON_FONT_COLOR;
        [_scoreButton addTarget:self action:@selector(scoreButtonAction) forControlEvents:UIControlEventTouchDown];

        [self addSubview:_scoreButton];
    }
    
    return _scoreButton;
}

- (void) layoutSubviews
{
    [ClientEngine startEngine];
    [ClientEngine setMustConsiderHeader:NO];
    [ClientEngine setCurrentOrientation:self.currentOrientation ];

    ColumnModel *columnLogo = [[ColumnModel alloc] initWithFixed:@125];
    ColumnModel *columnTitle = [[ColumnModel alloc] initWithFixed:@200];
    ColumnModel *columnMenu1 = [[ColumnModel alloc] initWithPercent:@100];
    
    LineModel *line1 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:columnLogo, columnTitle, columnMenu1, nil]];
    line1.height = @125;
    [ClientEngine addLine:line1];

    _title.offsetX = 30.0f;
    [ClientEngine applyFrame:_title withLine:line1 andColumn:columnTitle];
    
    [ClientEngine applyFrame:_logo withLine:line1 andColumn:columnLogo];
    
    [ClientEngine applyFrame:_scoreButton withLine:line1 andColumn:columnMenu1];
    
    _logo.backgroundColor = [UIColor yellowColor];
    _logo.userInitials.textColor = [UIColor blackColor];
    _logo.userInitials.text = @"CD";
    
}

- (void) scoreButtonAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_SCORE
                                                        object:self
                                                      userInfo:nil];
}

@end
