//
//  GroupView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/26/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"

@protocol GroupDataSource <NSObject>

- (GroupModel *) selectedGroup;

@end

@interface GroupView : UIView

@property (strong) id <GroupDataSource> dataSource;

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
- (void) updateData;

@end
