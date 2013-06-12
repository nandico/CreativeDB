//
//  AppDelegate.h
//  CreativeDBiOS
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
