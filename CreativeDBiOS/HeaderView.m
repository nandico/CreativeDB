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

@end

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:HEADER_BACKGROUND_COLOR];
        [self title];
    }
    return self;
}

- (HeaderLabel *) title
{
    if(!_title)
    {
        _title = [[HeaderLabel alloc] initWithFrame:CGRectMake( 30.0f, 0, 300.0f, 80.0f)];
        [_title setText:@"CreativeDB"];
        [self addSubview:_title];
    }
    
    return _title;
}

@end
