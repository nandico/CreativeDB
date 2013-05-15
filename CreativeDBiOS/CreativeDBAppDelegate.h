//
//  CreativeDBAppDelegate.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/15/13.
//  Copyright 2013 Cacau. All rights reserved.
//

@class Isgl3dViewController;

@interface CreativeDBAppDelegate : NSObject <UIApplicationDelegate> {

@private
	Isgl3dViewController * _viewController;
	UIWindow * _window;
}

@property (nonatomic, retain) UIWindow * window;

@end
