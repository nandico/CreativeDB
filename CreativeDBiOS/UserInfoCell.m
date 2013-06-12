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
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    
    _name.frame = CGRectMake( boundsX + 140, 10, 200, 50 );
    _country.frame = CGRectMake( boundsX + 160, 70, 200, 50 );
    _position.frame = CGRectMake( boundsX + 10, 20, 100, 50 );
    _score.frame = CGRectMake( boundsX + 400, 20, 200, 50 );
    _flag.frame = CGRectMake( boundsX + 140, 90, 16, 11 );
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
