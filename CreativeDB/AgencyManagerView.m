//
//  AgencyManagerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AgencyManagerView.h"
#import "ManagerEngine.h"
#import "ManagerActionBar.h"

@interface  AgencyManagerView()

@property (nonatomic, strong) ManagerEngine *engine;
@property (nonatomic, strong) ManagerFieldContainer *name;
@property (nonatomic, strong) ManagerFieldContainer *group;
@property (nonatomic, strong) ManagerFieldContainer *country;
@property (nonatomic, strong) ManagerActionBar *actionBar;

@end

@implementation AgencyManagerView

- (id)init
{
    self = [super init];
    if (self)
    {
        _engine = [[ManagerEngine alloc] init];
    }
    return self;
}

- (void) createForm
{
    [_engine addFieldContainer:[self name]];
    [_engine addFieldContainer:[self group]];
    [_engine addFieldContainer:[self country]];
    
    [_engine addActionBar:[self actionBar]];
    
    [_engine arrangeContainers];
}

- (void) destroyForm
{
    [_engine removeContainers];
    
    [self.name removeFromSuperview];
    [self.group removeFromSuperview];
    [self.country removeFromSuperview];
    
    _name = nil;
    _group = nil;
    _country = nil;
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


- (ManagerFieldContainer *)group
{
    if(!_group)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"group"];
        _group = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_group];
    }
    
    return _group;
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




@end
