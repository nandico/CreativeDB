//
//  AppDelegate.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/18/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AppDelegate.h"
#import "ScoreController.h"


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Disabled for perormance reasons
    // [ScoreController processAwards];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    _mainManager = [[MainManagerViewController alloc] init];
    self.window.contentView = _mainManager.view;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
    return YES;
}



@end
