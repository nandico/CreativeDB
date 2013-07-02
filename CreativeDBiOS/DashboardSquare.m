//
//  DashboardSquare.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "DashboardSquare.h"

@interface DashboardSquare()

@property (nonatomic) UIDeviceOrientation currentOrientation;
@property (strong, nonatomic) ClientEngine *engine;

@end

@implementation DashboardSquare

- (id) init
{
    self = [super init];
    if (self) {
        [self background];
        [self title];
        [self content];
         
        _engine = [[ClientEngine alloc] init];
        
    }
    
    return self;
    
}

- (void) layoutSubviews
{
    CGRect container = self.frame;
    CGFloat backgroundMargin = 10;
    
    _background.frame = CGRectMake( backgroundMargin,
                                   backgroundMargin,
                                   container.size.width - ( backgroundMargin * 2 ),
                                   container.size.height - (backgroundMargin * 2 ));
    
    _title.frame = CGRectMake( backgroundMargin,
                                10.0f,
                                container.size.width - ( backgroundMargin * 2 ),
                                container.size.height - (backgroundMargin * 2 ));
    
    _content.frame = CGRectMake( backgroundMargin,
                                80.0f,
                                container.size.width - ( backgroundMargin * 2 ),
                                container.size.height - (backgroundMargin * 2 ));
    


}

- (BaseView *) background
{
    if( !_background )
    {
        _background = [[BaseView alloc] init];
        _background.backgroundColor = PALLETE_CLEAR;
        [self addSubview:_background];
    }
    
    return _background;
}

- (H1Label *) title
{
    if( !_title )
    {
        _title = [[H1Label alloc] init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = PALLETE_WHITE_FOR_ELEMENTS;
        
        _title.font = LABEL_BIGGEST_FONT;
        
        _title.numberOfLines = 1;
        _title.minimumScaleFactor = 0.5f;
        _title.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:_title];
    }
    
    return _title;
}

- (H2Label *) content
{
    if( !_content )
    {
        _content = [[H2Label alloc] init];
        _content.textAlignment = NSTextAlignmentCenter;
        _content.textColor = PALLETE_WHITE_FOR_ELEMENTS;
        [self addSubview:_content];
    }
    
    return _content;
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
        _currentOrientation = orientation;
        [_engine setCurrentOrientation:_currentOrientation];
        [self layoutSubviews];
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        _currentOrientation = orientation;
        [_engine setCurrentOrientation:_currentOrientation];
        [self layoutSubviews];
    }
}


@end
