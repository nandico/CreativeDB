//
//  UserInfoCell.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/11/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _name = [[NameLabel alloc] init];
        _country = [[CountryLabel alloc] init];
        _position = [[PositionLabel alloc] init];
        _score = [[ScoreLabel alloc] init];
        _flag = [[CountryImageView alloc] init];
        
        [self.contentView addSubview:_name];
        [self.contentView addSubview:_country];
        [self.contentView addSubview:_position];
        [self.contentView addSubview:_score];
        [self.contentView addSubview:_flag];
    }
    return self;
}

- (void) layoutSubviews
{
    
    [ClientEngine startEngine];
    [ClientEngine setMustConsiderHeader:NO];
    [ClientEngine setCurrentOrientation:[self.dataSource currentOrientation] ];

    ColumnModel *column1 = [[ColumnModel alloc] initWithPercent:@20];
    ColumnModel *column2 = [[ColumnModel alloc] initWithPercent:@60];
    ColumnModel *column3 = [[ColumnModel alloc] initWithPercent:@20];

    LineModel *line1 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column1, column2, column3, nil]];
    line1.height = @125;
    [ClientEngine addLine:line1];

    _position.backgroundColor = [UIColor cyanColor];
    [ClientEngine applyFrame:_position withLine:line1 andColumn:column1];
    
    _name.prefferedHeight = 50.0f;
    _name.offsetX = 30.0f;
    _name.offsetY = 20.0f;
    
    [ClientEngine applyFrame:_name withLine:line1 andColumn:column2];
    
    _country.prefferedHeight = 50.0f;
    _country.offsetX = 50.0f;
    _country.offsetY = 55.0f;
    
    [ClientEngine applyFrame:_country withLine:line1 andColumn:column2];
    
    _flag.prefferedWidth = 16.0f;
    _flag.prefferedHeight = 11.0f;
    _flag.offsetX = 30.0f;
    _flag.offsetY = 74.0f;
    
    [ClientEngine applyFrame:_flag withLine:line1 andColumn:column2];

    _score.backgroundColor = [UIColor magentaColor];
    [ClientEngine applyFrame:_score withLine:line1 andColumn:column3];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
