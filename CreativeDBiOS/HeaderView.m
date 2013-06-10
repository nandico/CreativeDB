//
//  HeaderView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "HeaderView.h"
#import "HeaderLabel.h"

@interface HeaderView()

@property (strong, nonatomic) HeaderLabel *title;

@end

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor redColor]];
        [self title];
    }
    return self;
}

- (HeaderLabel *) title
{
    if(!_title)
    {
        _title = [[HeaderLabel alloc] initWithFrame:CGRectMake(0, 0, 500.0f, 100.0f)];
        [_title setText:@"CreativeDB"];
        [self addSubview:_title];
    }
    
    return _title;
}

@end
