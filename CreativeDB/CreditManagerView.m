//
//  CreditManagerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 4/22/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CreditManagerView.h"
#import "ManagerEngine.h"


@interface  CreditManagerView()

@property (nonatomic, strong) ManagerFieldContainer *person;
@property (nonatomic, strong) ManagerFieldContainer *entry;
@property (nonatomic, strong) ManagerFieldContainer *role;
@property (nonatomic, strong) ManagerFieldContainer *producer;

@end

@implementation CreditManagerView

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
    [_engine addFieldContainer:[self person]];
    [_engine addFieldContainer:[self role]];
    [_engine addFieldContainer:[self producer]];
    
    [_engine addActionBar:[self actionBar]];
    
    [_engine arrangeContainers];
    
}

- (void) destroyForm
{
    [_engine removeContainers];
    
    [self.person removeFromSuperview];
    [self.entry removeFromSuperview];
    [self.role removeFromSuperview];
    [self.producer removeFromSuperview];
    
    _person = nil;
    _entry = nil;
    _role = nil;
    _producer = nil;
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


- (ManagerFieldContainer *)person
{
    if(!_person)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"person"];
        _person = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_person];
    }
    
    return _person;
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

- (ManagerFieldContainer *)role
{
    if(!_role)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"role"];
        _role = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_role];
    }
    
    return _role;
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

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

