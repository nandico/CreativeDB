//
//  GroupViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/26/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupView.h"

@interface GroupViewController : UIViewController <GroupDataSource>

@property (strong) GroupModel *selectedGroup;
- (void) updateOrientation:( UIDeviceOrientation ) orientation;


@end
