//
//  MarkerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 7/7/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "MarkerView.h"
#import "ClientEngine.h"

@interface MarkerView()

@property (nonatomic, strong) UIView *horizontal;
@property (nonatomic, strong) UIView *vertical;

@end

@implementation MarkerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self horizontal];
        [self vertical];
    }
    return self;
}

- (UIView *) horizontal
{
    if( !_horizontal )
    {
        _horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 12, 2)];
        _horizontal.backgroundColor = PALLETE_WHITE_FOR_ELEMENTS;
        [self addSubview:_horizontal];
    }
    
    return _horizontal;
}

- (UIView *) vertical
{
    if( !_vertical )
    {
        _vertical = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 2, 12)];
        _vertical.backgroundColor = PALLETE_WHITE_FOR_ELEMENTS;
        [self addSubview:_vertical];
    }
    
    return _vertical;
}


@end
