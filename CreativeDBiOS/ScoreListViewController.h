//
//  ScoreListViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

- (void) updateOrientation:( UIDeviceOrientation ) orientation;

@end
