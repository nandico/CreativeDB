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

@interface HeaderView()

@property (strong, nonatomic) HeaderLabel *title;

@property (strong, nonatomic) BaseButton *scoreButton;

@end

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:HEADER_BACKGROUND_COLOR];
        [self title];
        [self scoreButton];
    }
    return self;
}

- (HeaderLabel *) title
{
    if(!_title)
    {
        _title = [[HeaderLabel alloc] initWithFrame:HEADER_LOGO_FRAME];
        [_title setText:APP_NAME];
        [self addSubview:_title];
    }
    
    return _title;
}

- (BaseButton *) scoreButton
{
    if( !_scoreButton )
    {
        _scoreButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        _scoreButton.frame = CGRectMake( 300.0f, 16.0f, 100.0f, 50.0f );
        [_scoreButton setTitle:@"Score" forState:UIControlStateNormal];
        _scoreButton.titleLabel.font = MENU_BUTTON_FONT;
        _scoreButton.titleLabel.textColor = MENU_BUTTON_FONT_COLOR;
        [_scoreButton addTarget:self action:@selector(scoreButtonAction) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_scoreButton];
    }
    
    return _scoreButton;
}

- (void) scoreButtonAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_SCORE
                                                        object:self
                                                      userInfo:nil];
}

@end
