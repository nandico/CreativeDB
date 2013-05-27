//
//  ProducerCreditManagerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/10/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProducerCreditManagerView.h"

@interface  ProducerCreditManagerView()

@property (nonatomic, strong) ManagerFieldContainer *entry;
@property (nonatomic, strong) ManagerFieldContainer *producer;
@property (nonatomic, strong) ManagerFieldContainer *discipline;

@end

@implementation ProducerCreditManagerView

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
    
    [_engine addFieldContainer:[self entry]];
    [_engine addFieldContainer:[self producer]];
    [_engine addFieldContainer:[self discipline]];
    
    [_engine addActionBar:[self actionBar]];
    
    [_engine arrangeContainers];
    
}

- (void) destroyForm
{
    [_engine removeContainers];
    
    [self.entry removeFromSuperview];
    [self.producer removeFromSuperview];
    [self.discipline removeFromSuperview];
    
    _entry = nil;
    _producer = nil;
    _discipline = nil;
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

- (ManagerFieldContainer *)entry
{
    if(!_entry)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"entry"];
        _entry = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_entry];
    }
    
    return _entry;
}


- (ManagerFieldContainer *)producer
{
    if(!_producer)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"producer"];
        _producer = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_producer];
    }
    
    return _producer;
}

- (ManagerFieldContainer *)discipline
{
    if(!_discipline)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"discipline"];
        _discipline = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_discipline];
    }
    
    return _discipline;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
