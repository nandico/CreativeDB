//
//  AwardManagerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/12/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AwardManagerView.h"

@interface  AwardManagerView()

@property (nonatomic, strong) ManagerFieldContainer *entry;
@property (nonatomic, strong) ManagerFieldContainer *metal;
@property (nonatomic, strong) ManagerFieldContainer *festival;
@property (nonatomic, strong) ManagerFieldContainer *category;
@property (nonatomic, strong) ManagerFieldContainer *subcategory;
@property (nonatomic, strong) ManagerFieldContainer *year;

@end

@implementation AwardManagerView

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
    [_engine addFieldContainer:[self metal]];
    [_engine addFieldContainer:[self festival]];
    [_engine addFieldContainer:[self category]];
    [_engine addFieldContainer:[self subcategory]];
    [_engine addFieldContainer:[self year]];
    
    [_engine addActionBar:[self actionBar]];
    
    [_engine arrangeContainers];
    
}

- (void) destroyForm
{
    [_engine removeContainers];
    
    [self.entry removeFromSuperview];
    [self.metal removeFromSuperview];
    [self.festival removeFromSuperview];
    [self.category removeFromSuperview];
    [self.subcategory removeFromSuperview];
    [self.year removeFromSuperview];
    
    _entry = nil;
    _metal = nil;
    _festival = nil;
    _category = nil;
    _subcategory = nil;
    _year = nil;
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

- (ManagerFieldContainer *)metal
{
    if(!_metal)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"metal"];
        _metal = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_metal];
    }
    
    return _metal;
}

- (ManagerFieldContainer *)festival
{
    if(!_festival)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"festival"];
        _festival = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_festival];
    }
    
    return _festival;
}

- (ManagerFieldContainer *)category
{
    if(!_category)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"category"];
        _category = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_category];
    }
    
    return _category;
}

- (ManagerFieldContainer *)subcategory
{
    if(!_subcategory)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"subcategory"];
        _subcategory = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_subcategory];
    }
    
    return _subcategory;
}

- (ManagerFieldContainer *)year
{
    if(!_year)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"year"];
        _year = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_year];
    }
    
    return _year;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
