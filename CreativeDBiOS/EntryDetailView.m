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
    
    _year.frame = CGRectMake( boundsX + 0, 10, 140, 50 );
    _metal.frame = CGRectMake( boundsX + 140, 10, 100, 50 );
    _entry.frame = CGRectMake( boundsX + 240, 10, 400, 50 );
    _client.frame = CGRectMake( boundsX + 240, 50, 400, 50 );
    _product.frame = CGRectMake( boundsX + 240, 100, 400, 50 );
    _festival.frame = CGRectMake( boundsX + 640, 10, 200, 50 );
    _category.frame = CGRectMake( boundsX + 640, 50, 200, 50 );
    _subcategory.frame = CGRectMake( boundsX + 640, 100, 200, 50 );
}

- (void) updateData
{
    if( !_selectedEntry ) return;
    if( !_selectedAward ) return;
        
    self.year.text = [NSString stringWithFormat:@"     %@", _selectedAward.year ];
    self.year.backgroundColor = [UIColor lightGrayColor];
    self.metal.text = _selectedAward.metal.name;
    self.metal.backgroundColor = [UIColor yellowColor];
    self.entry.text = _selectedEntry.name;
    self.entry.backgroundColor = [UIColor cyanColor];
    self.client.text = _selectedEntry.client.name;
    self.product.text = ( _selectedEntry.product ) ? _selectedEntry.product.name : @"";
    self.festival.text = _selectedAward.festival.name;
    self.festival.backgroundColor = [UIColor lightGrayColor];
    self.category.text = _selectedAward.category.name;
    self.subcategory.text = ( _selectedAward.subcategory ) ? _selectedAward.subcategory.name : @"";
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

- (H1Label *) festival
{
    if( !_festival )
    {
        _festival = [[H1Label alloc] init];
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
