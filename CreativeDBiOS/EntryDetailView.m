//
//  EntryDetailView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/13/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryDetailView.h"

@interface EntryDetailView()

@property (nonatomic) UIDeviceOrientation currentOrientation;

@end

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
    CGFloat lineHeigth = 45.0f;

    [ClientEngine startEngine];
    [ClientEngine setMustConsiderHeader:NO];
    [ClientEngine setCurrentOrientation:_currentOrientation];
    
    ColumnModel *column1 = [[ColumnModel alloc] initWithPercent:@20];
    ColumnModel *column2 = [[ColumnModel alloc] initWithPercent:@10];
    ColumnModel *column3 = [[ColumnModel alloc] initWithPercent:@30];
    ColumnModel *column4 = [[ColumnModel alloc] initWithPercent:@30];
    ColumnModel *column5 = [[ColumnModel alloc] initWithPercent:@10];

    LineModel *line1 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column1, column2, column3, column4, column5, nil]];
    line1.height = [NSNumber numberWithFloat:lineHeigth];
    [ClientEngine addLine:line1];
    
    _year.prefferedHeight = lineHeigth;
    [ClientEngine applyFrame:_year withLine:line1 andColumn:column1];
    
    _metal.prefferedHeight = lineHeigth;
    [ClientEngine applyFrame:_metal withLine:line1 andColumn:column2];
    
    _entry.prefferedHeight = lineHeigth;
    [ClientEngine applyFrame:_entry withLine:line1 andColumn:column3];
    
    _festival.prefferedHeight = lineHeigth;
    [ClientEngine applyFrame:_festival withLine:line1 andColumn:column4];
    
    LineModel *line2 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column1, column2, column3, column4, column5, nil]];
    line2.height = [NSNumber numberWithFloat:lineHeigth];
    [ClientEngine addLine:line2];
    
    [ClientEngine applyFrame:_client withLine:line2 andColumn:column3];
    [ClientEngine applyFrame:_category withLine:line2 andColumn:column4];
    
    LineModel *line3 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column1, column2, column3, column4, column5, nil]];
    line3.height = [NSNumber numberWithFloat:lineHeigth];
    [ClientEngine addLine:line3];
    
    [ClientEngine applyFrame:_product withLine:line3 andColumn:column3];
    [ClientEngine applyFrame:_subcategory withLine:line3 andColumn:column4];
    
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

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
        _currentOrientation = orientation;
        [ClientEngine setCurrentOrientation:_currentOrientation];
        [self layoutSubviews];
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        _currentOrientation = orientation;
        [ClientEngine setCurrentOrientation:_currentOrientation];
        [self layoutSubviews];
    }
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
