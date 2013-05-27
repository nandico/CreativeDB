//
//  ProductManagerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/23/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProductManagerView.h"

@interface  ProductManagerView()

@property (nonatomic, strong) ManagerFieldContainer *name;
@property (nonatomic, strong) ManagerFieldContainer *client;

@end


@implementation ProductManagerView

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
    
    [_engine addFieldContainer:[self client]];
    [_engine addFieldContainer:[self name]];
    
    [_engine addActionBar:[self actionBar]];
    
    [_engine arrangeContainers];
}

- (void) destroyForm
{
    [_engine removeContainers];
    
    [self.name removeFromSuperview];
    [self.client removeFromSuperview];
    
    _name = nil;
    _client = nil;
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

- (ManagerFieldContainer *)client
{
    if(!_client)
    {
        
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"client"];
        _client = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_client];
    }
    
    return _client;
}

@end
