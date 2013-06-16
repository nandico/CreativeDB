//
//  UserInfoCell.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/11/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NameLabel.h"
#import "CountryLabel.h"
#import "PositionLabel.h"
#import "ScoreLabel.h"
#import "CountryImageView.h"
#import "PersonIdView.h"

@protocol UserInfoDataSource <NSObject>

@property (nonatomic) UIDeviceOrientation currentOrientation;

@end

@interface UserInfoCell : UITableViewCell

@property (assign) id <UserInfoDataSource> dataSource;

@property (nonatomic, strong) PersonIdView *thumb;
@property (nonatomic, strong) NameLabel *name;
@property (nonatomic, strong) CountryLabel *country;
@property (nonatomic, strong) PositionLabel *position;
@property (nonatomic, strong) ScoreLabel *score;
@property (nonatomic, strong) CountryImageView *flag;

@end
