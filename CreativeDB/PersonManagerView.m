//
//  PersonManagerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonManagerView.h"

@interface  PersonManagerView()

@property (nonatomic, strong) ManagerFieldContainer *name;
@property (nonatomic, strong) ManagerFieldContainer *country;
@property (nonatomic, strong) ManagerFieldContainer *portfolioURL;

@end

@implementation PersonManagerView

- (id)init
{
    self = [super init];
    if (self)
    {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [MLE_BACKGROUND_COLOR CGColor];
        _engine = [[ManagerEngine alloc] init];
    }
    return self;
}

- (void) createForm
{
    [_engine addFieldContainer:[self name]];
    [_engine addFieldContainer:[self country]];
    [_engine addFieldContainer:[self portfolioURL]];
    
    [_engine addActionBar:[self actionBar]];
    
    [_engine arrangeContainers];
}

- (void) destroyForm
{
    [_engine removeContainers];
    
    [self.name removeFromSuperview];
    [self.country removeFromSuperview];
    [self.portfolioURL removeFromSuperview];
    
    _name = nil;
    _country = nil;
    _portfolioURL = nil;
}

- (ManagerActionBar *) actionBar
{
    if(!_actionBar)
    {
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 nil];
        
        _actionBar = [[ManagerActionBar alloc] initWithOptions:options];
        
        [self addSubview:_actionBar];
    }
    
    return _actionBar;
}

- (ManagerFieldContainer *)name
{
    if(!_name)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"name"];
        _name = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_name];
    }
    
    return _name;
}

- (ManagerFieldContainer *)country
{
    if(!_country)
    {
        
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"country"];
        _country = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_country];
    }
    
    return _country;
}

- (ManagerFieldContainer *)portfolioURL
{
    if(!_portfolioURL)
    {
        
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"portfolioURL"];
        _portfolioURL = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_portfolioURL];
    }
    
    return _portfolioURL;
}

@end
