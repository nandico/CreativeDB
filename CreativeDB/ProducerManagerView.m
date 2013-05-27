//
//  ProducerManagerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProducerManagerView.h"

@interface ProducerManagerView()

@property (nonatomic, strong) ManagerFieldContainer *country;
@property (nonatomic, strong) ManagerFieldContainer *name;
@property (nonatomic, strong) ManagerFieldContainer *siteURL;

@end


@implementation ProducerManagerView

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
    [_engine addHeader:[self header]];
    
    [_engine addFieldContainer:[self name]];
    [_engine addFieldContainer:[self country]];
    [_engine addFieldContainer:[self siteURL]];
    
    [_engine addActionBar:[self actionBar]];
    
    [_engine arrangeContainers];
}

- (void) destroyForm
{
    [_engine removeContainers];
    
    [self.country removeFromSuperview];
    [self.name removeFromSuperview];
    [self.siteURL removeFromSuperview];
    
    _country = nil;
    _name = nil;
    _siteURL = nil;
}

- (ManagerHeader *) header
{
    if(!_header)
    {
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [self.dataSource modelTitle], MLE_FIELDSET_MODEL_HEADERTITLE, nil ];
        
        _header = [[ManagerHeader alloc] initWithOptions:options];
        
        [self addSubview:_header];
    }
    
    return _header;
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

- (ManagerFieldContainer *)siteURL
{
    if(!_siteURL)
    {
        
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"siteURL"];
        _siteURL = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_siteURL];
    }
    
    return _siteURL;
}


@end
