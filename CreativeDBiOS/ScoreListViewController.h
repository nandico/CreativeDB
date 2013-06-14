//
//  ScoreListViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoCell.h"

@interface ScoreListViewController : UITableViewController <UserInfoDataSource>

@property (nonatomic) UIDeviceOrientation currentOrientation;
- (void) updateOrientation:( UIDeviceOrientation ) orientation;

@end
