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
        
        [self.contentView addSubview:_name];
        [self.contentView addSubview:_country];
        [self.contentView addSubview:_position];
        [self.contentView addSubview:_score];
    }
    return self;
}

- (void) layoutSubviews
{
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    
    _name.frame = CGRectMake( boundsX + 100, 10, 200, 50 );
    _country.frame = CGRectMake( boundsX + 100, 70, 200, 50 );
    _position.frame = CGRectMake( boundsX + 10, 20, 60, 50 );
    _score.frame = CGRectMake( boundsX + 400, 20, 200, 50 );
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
