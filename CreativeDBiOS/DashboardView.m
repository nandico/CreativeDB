//
//  DashboardView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "DashboardView.h"
#import "ClientEngine.h"
#import "BaseView.h"

@interface DashboardView()

@property (nonatomic, strong) ClientEngine *engine;
@property (nonatomic) UIDeviceOrientation currentOrientation;

@property (strong, nonatomic) BaseView *background;

@end

@implementation DashboardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor brownColor];
        
        [self background];
        
        _engine = [[ClientEngine alloc] init];
        
    }
    return self;
}

- (BaseView *) background
{
    if( !_background )
    {
        _background = [[BaseView alloc] init];
        _background.backgroundColor = [UIColor whiteColor];
        [self addSubview:_background];
    }
    
    return _background;
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


@end
