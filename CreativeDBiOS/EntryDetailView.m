//
//  EntryDetailView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/13/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryDetailView.h"


@implementation EntryDetailView

- (id) init
{
    self = [super init];
    if (self) {
        [self year];
        [self metal];
        [self entry];
        [self client];
        [self product];
        [self festival];
        [self category];
        [self subcategory];
    }
    
    return self;

}

- (void) layoutSubviews
{
    CGRect contentRect = self.bounds;
    CGFloat boundsX = contentRect.origin.x;
    
    _year.frame = CGRectMake( boundsX + 40, 10, 100, 50 );
    _metal.frame = CGRectMake( boundsX + 140, 10, 100, 50 );
    _entry.frame = CGRectMake( boundsX + 240, 10, 100, 50 );
    _client.frame = CGRectMake( boundsX + 240, 60, 100, 50 );
    _product.frame = CGRectMake( boundsX + 240, 120, 100, 50 );
    _festival.frame = CGRectMake( boundsX + 340, 10, 100, 50 );
    _category.frame = CGRectMake( boundsX + 340, 60, 100, 50 );
    _subcategory.frame = CGRectMake( boundsX + 340, 120, 100, 50 );
}

- (void) updateData
{
    self.year.text = @"2013";
    self.metal.text = @"Gold";
    self.metal.backgroundColor = [UIColor yellowColor];
    self.entry.text = @"Inonon lonenlita";
    self.client.text = @"Fiat";
    self.product.text = @"Cinquecento";
    self.festival.text = @"One Show";
    self.category.text = @"Interactive";
    self.subcategory.text = @"Best use of Internet";
}


- (H1Label *) year
{
    if( !_year )
    {
        _year = [[H1Label alloc] init];
        [self addSubview:_year];
    }
    
    return _year;
}

- (H2Label *) metal
{
    if( !_metal )
    {
        _metal = [[H2Label alloc] init];
        [self addSubview:_metal];
    }
    
    return _metal;
}

- (H3Label *) entry
{
    if( !_entry )
    {
        _entry = [[H3Label alloc] init];
        [self addSubview:_entry];
    }
    
    return _entry;
}

- (H3Label *) client
{
    if( !_client )
    {
        _client = [[H3Label alloc] init];
        [self addSubview:_client];
    }
    
    return _client;
}

- (H3Label *) product
{
    if( !_product )
    {
        _product = [[H3Label alloc] init];
        [self addSubview:_product];
    }
    
    return _product;
}

- (H3Label *) festival
{
    if( !_festival )
    {
        _festival = [[H3Label alloc] init];
        [self addSubview:_festival];
    }
    
    return _festival;
}

- (H3Label *) category
{
    if( !_category )
    {
        _category = [[H3Label alloc] init];
        [self addSubview:_category];
    }
    
    return _category;
}

- (H3Label *) subcategory
{
    if( !_subcategory )
    {
        _subcategory = [[H3Label alloc] init];
        [self addSubview:_subcategory];
    }
    
    return _subcategory;
}

@end
