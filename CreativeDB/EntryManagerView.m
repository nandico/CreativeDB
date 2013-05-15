//
//  EntryManagerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/30/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryManagerView.h"
#import "ManagerEngine.h"


@interface  EntryManagerView()


@property (nonatomic, strong) ManagerFieldContainer *agency;
@property (nonatomic, strong) ManagerFieldContainer *client;
@property (nonatomic, strong) ManagerFieldContainer *country;
@property (nonatomic, strong) ManagerFieldContainer *product;
@property (nonatomic, strong) ManagerFieldContainer *accessURL;
@property (nonatomic, strong) ManagerFieldContainer *caseURL;
@property (nonatomic, strong) ManagerFieldContainer *blurb;
@property (nonatomic, strong) ManagerFieldContainer *name;
@property (nonatomic, strong) ManagerFieldContainer *year;

@end

@implementation EntryManagerView

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
    [_engine addFieldContainer:[self agency]];
    [_engine addFieldContainer:[self client]];
    [_engine addFieldContainer:[self country]];
    [_engine addFieldContainer:[self product]];
    [_engine addFieldContainer:[self accessURL]];
    [_engine addFieldContainer:[self caseURL]];
    [_engine addFieldContainer:[self blurb]];
    [_engine addFieldContainer:[self year]];

    [_engine addActionBar:[self actionBar]];
    
    [_engine arrangeContainers];
}

- (void) destroyForm
{
    [_engine removeContainers];
    
    [self.name removeFromSuperview];
    [self.agency removeFromSuperview];
    [self.client removeFromSuperview];
    [self.country removeFromSuperview];
    [self.product removeFromSuperview];
    [self.accessURL removeFromSuperview];
    [self.caseURL removeFromSuperview];
    [self.blurb removeFromSuperview];
    [self.year removeFromSuperview];
    
    _name = nil;
    _agency = nil;
    _client = nil;
    _country = nil;
    _product = nil;
    _accessURL = nil;
    _name = nil;
    _caseURL = nil;
    _blurb = nil;
    _year = nil;
    
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

- (ManagerFieldContainer *)agency
{
    if(!_agency)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"agency"];
        _agency = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_agency];
    }
    
    return _agency;
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

- (ManagerFieldContainer *)product
{
    if(!_product)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"product"];
        _product = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_product];
    }
    
    return _product;
}

- (ManagerFieldContainer *)accessURL
{
    if(!_accessURL)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"accessURL"];
        _accessURL = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_accessURL];
    }
    
    return _accessURL;
}

- (ManagerFieldContainer *)caseURL
{
    if(!_caseURL)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"caseURL"];
        _caseURL = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_caseURL];
    }
    
    return _caseURL;
}

- (ManagerFieldContainer *)blurb
{
    if(!_blurb)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"blurb"];
        _blurb = [[ManagerFieldContainer alloc] initWithOptions:options];
        [self addSubview:_blurb];
    }
    
    return _blurb;
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
