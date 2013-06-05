//
//  ScoreListView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/4/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ScoreListView.h"
#import "ManagerFilterContainer.h"

@interface  ScoreListView()

@property (nonatomic, strong) ManagerFilterContainer *country;

@end

@implementation ScoreListView

- (id)init
{
    self = [super init];
    if (self)
    {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [MLE_BACKGROUND_COLOR CGColor];
    }
    return self;
}

- (void) createForm
{
    [self country];
        
    //[_engine arrangeContainers];
}

- (void) destroyForm
{
    //[_engine removeContainers];
    
    [self.country removeFromSuperview];
    
    _country = nil;
}

- (ManagerFilterContainer *)country
{
    if(!_country)
    {
        
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"country"];
        
        NSLog( @"Opa: %@ - datasource: %@", options, self.dataSource );
        
        _country = [[ManagerFilterContainer alloc] initWithOptions:options];
        
        [self addSubview:_country];
    }
    
    return _country;
}



@end
