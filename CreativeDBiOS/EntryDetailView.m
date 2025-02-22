//
//  EntryDetailView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/13/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryDetailView.h"
#import "CreditModel.h"

@interface EntryDetailView()

@property (nonatomic) UIDeviceOrientation currentOrientation;
@property (strong, nonatomic) ClientEngine *engine;
@property (nonatomic, strong) NSMutableArray *credits;

@end

@implementation EntryDetailView

- (id) init
{
    self = [super init];
    if (self) {
        [self roles];
        [self year];
        [self metal];
        [self entry];
        [self agency];
        [self client];
        [self product];
        [self festival];
        [self category];
        [self subcategory];
        
        _engine = [[ClientEngine alloc] init];

    }
    
    return self;

}

- (void) layoutSubviews
{
    CGFloat lineHeigth = 45.0f;
    
    [_engine startEngine];
    [_engine setMustConsiderHeader:NO];
    [_engine setCurrentOrientation:_currentOrientation];

    if( _selectedPerson )
    {
        ColumnModel *column_role = [[ColumnModel alloc] initWithPercent:@100];
        ColumnModel *column_role_space = [[ColumnModel alloc] initWithFixed:@125];
        LineModel *line0 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column_role, column_role_space, nil]];
        line0.height = [NSNumber numberWithFloat:lineHeigth];
        [_engine addLine:line0];
        
        _roles.offsetX = APP_LEFT_PADDING;
        [_engine applyFrame:_roles withLine:line0 andColumn:column_role];
    }
    
    ColumnModel *column1 = [[ColumnModel alloc] initWithPercent:@20];
    ColumnModel *column2 = [[ColumnModel alloc] initWithPercent:@21.8];
    ColumnModel *column3 = [[ColumnModel alloc] initWithPercent:@29.2];
    ColumnModel *column4 = [[ColumnModel alloc] initWithPercent:@29];
    ColumnModel *column5 = [[ColumnModel alloc] initWithFixed:@125];
    
    LineModel *line1 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column1, column2, column3, column4, column5, nil]];
    line1.height = [NSNumber numberWithFloat:lineHeigth];
    [_engine addLine:line1];
    
    _year.prefferedHeight = lineHeigth;
    [_engine applyFrame:_year withLine:line1 andColumn:column1];
    
    _metal.prefferedHeight = lineHeigth;
    [_engine applyFrame:_metal withLine:line1 andColumn:column2];
    
    _entry.prefferedHeight = lineHeigth;
    [_engine applyFrame:_entry withLine:line1 andColumn:column3];
    
    _festival.prefferedHeight = lineHeigth;
    [_engine applyFrame:_festival withLine:line1 andColumn:column4];
    
    ColumnModel *column1L2 = [[ColumnModel alloc] initWithPercent:@20];
    ColumnModel *column2L2 = [[ColumnModel alloc] initWithPercent:@51];
    ColumnModel *column3L2 = [[ColumnModel alloc] initWithPercent:@29];
    ColumnModel *column4L2 = [[ColumnModel alloc] initWithFixed:@125];
    
    LineModel *line2 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column1L2, column2L2, column3L2, column4L2, nil]];
    line2.height = [NSNumber numberWithFloat:lineHeigth];
    [_engine addLine:line2];
    
    [_engine applyFrame:_category withLine:line2 andColumn:column3L2];
    
    LineModel *line3 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column1L2, column2L2, column3L2, column4L2, nil]];
    line3.height = [NSNumber numberWithFloat:lineHeigth];
    [_engine addLine:line3];

    [_engine applyFrame:_client withLine:line3 andColumn:column2L2];
    [_engine applyFrame:_agency withLine:line2 andColumn:column2L2];
 
    LineModel *line4 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column1L2, column2L2, column3L2, column4L2, nil]];
    line4.height = [NSNumber numberWithFloat:lineHeigth];
    [_engine addLine:line4];
    
    [_engine applyFrame:_product withLine:line4 andColumn:column2L2];
    [_engine applyFrame:_subcategory withLine:line3 andColumn:column3L2];
    
}

- (void) updateData
{
    if( !_credits )
    {
        _credits = [CreditModel loadByEntryId:_selectedEntry.pk];
    }
        
    if( !_selectedEntry ) return;
    if( !_selectedAward ) return;
    
    if( _selectedPerson )
    {
        self.roles.text = [NSString stringWithFormat:@"%@ - %@",
                           _selectedPerson.name,
                           [self stringfyRolesFromCredits:_credits forPersonId:_selectedPerson.pk]];
    }
    else
    {
        self.roles.text = @"";
    }
    
    self.year.text = [NSString stringWithFormat:@"      %@", _selectedAward.year ];
    self.year.backgroundColor = PALLETE_BASE_COLOR_I;
    self.metal.text = _selectedAward.metal.name;
    self.metal.backgroundColor = PALLETE_BASE_COLOR_B;
    self.metal.textColor = PALLETE_WHITE_FOR_ELEMENTS;
    self.entry.text = _selectedEntry.name;
    self.entry.backgroundColor = PALLETE_BASE_COLOR_C;
    self.entry.textColor = PALLETE_WHITE_FOR_ELEMENTS;
    self.client.text = _selectedEntry.client.name;
    self.agency.text = _selectedEntry.agency.name;
    self.product.text = ( _selectedEntry.product ) ? _selectedEntry.product.name : @"";
    self.festival.text = _selectedAward.festival.name;
    self.festival.backgroundColor = PALLETE_BASE_COLOR_I;
    self.category.text = _selectedAward.category.name;
    self.subcategory.text = ( _selectedAward.subcategory ) ? _selectedAward.subcategory.name : @"";
    
}

- (NSString *) stringfyRolesFromCredits:(NSMutableArray *) credits forPersonId:(NSNumber *) personId
{
    NSMutableString *roles = [[NSMutableString alloc] init];
    
    for( CreditModel *credit in credits )
    {
        if( [credit.personPK isEqualToNumber:personId] )
        {
            if( roles.length > 0 )
            {
                [roles appendString:[NSString stringWithFormat:@" / %@", credit.role.name ]];
            }
            else
            {
                [roles appendString:[NSString stringWithFormat:@"%@", credit.role.name ]];
            }
        }
    }
    
    return [roles stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
        _currentOrientation = orientation;
        [_engine setCurrentOrientation:_currentOrientation];
        [self layoutSubviews];
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        _currentOrientation = orientation;
        [_engine setCurrentOrientation:_currentOrientation];
        [self layoutSubviews];
    }
}

- (H3Label *) roles
{
    if( !_roles )
    {
        _roles = [[H3Label alloc] init];
        [self addSubview:_roles];
    }
    
    return _roles;
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

- (H3Label *) agency
{
    if( !_agency )
    {
        _agency = [[H3Label alloc] init];
        [self addSubview:_agency];
    }
    
    return _agency;
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
