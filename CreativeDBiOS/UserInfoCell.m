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
        _thumb = [[PersonIdView alloc] init];
        _name = [[NameLabel alloc] init];
        _country = [[CountryLabel alloc] init];
        _position = [[PositionLabel alloc] init];
        _score = [[ScoreLabel alloc] init];
        _flag = [[CountryImageView alloc] init];
        
        [self.contentView addSubview:_thumb];
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
    ClientEngine *engine = [[ClientEngine alloc] init];
    
    [engine startEngine];
    [engine setMustConsiderHeader:NO];
    [engine setCurrentOrientation:[self.dataSource currentOrientation] ];

    ColumnModel *column1 = [[ColumnModel alloc] initWithFixed:@125];
    ColumnModel *column2 = [[ColumnModel alloc] initWithFixed:@125];
    ColumnModel *column3 = [[ColumnModel alloc] initWithPercent:@100];
    ColumnModel *column4 = [[ColumnModel alloc] initWithFixed:@125];
    
    LineModel *line1 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:column1, column2, column3, column4, nil]];
    line1.height = @130;
    [engine addLine:line1];
    
    CGFloat rankingOffsetY = 3.0f;
    
    _position.backgroundColor = PALLETE_BASE_COLOR_G;
    _position.textAlignment = NSTextAlignmentCenter;
    _position.textColor = PALLETE_WHITE_FOR_ELEMENTS;
    [engine applyFrame:_position withLine:line1 andColumn:column1];
    
    _score.backgroundColor = PALLETE_BASE_COLOR_D;
    _score.textAlignment = NSTextAlignmentCenter;
    _score.textColor = PALLETE_WHITE_FOR_ELEMENTS;
    [engine applyFrame:_score withLine:line1 andColumn:column2];

    
    _name.prefferedHeight = 50.0f;
    _name.offsetX = 30.0f;
    _name.offsetY = 20.0f + rankingOffsetY;
    _name.textColor = PALLETE_BLACK_FOR_ELEMENTS;
    
    [engine applyFrame:_name withLine:line1 andColumn:column3];
    
    _country.prefferedHeight = 50.0f;
    _country.offsetX = 50.0f;
    _country.offsetY = 57.0f + rankingOffsetY;
    _country.textColor = PALLETE_BLACK_FOR_ELEMENTS;
    
    [engine applyFrame:_country withLine:line1 andColumn:column3];
    
    _flag.prefferedWidth = 16.0f;
    _flag.prefferedHeight = 11.0f;
    _flag.offsetX = 30.0f;
    _flag.offsetY = 76.0f + rankingOffsetY;
    [_flag setAlpha:0.7f];
    
    [engine applyFrame:_flag withLine:line1 andColumn:column3];
    
    _thumb.backgroundColor = PALLETE_BASE_COLOR_A;
    [engine applyFrame:_thumb withLine:line1 andColumn:column4];
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
