//
//  AppDelegate.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/18/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _mainManager = [[MainManagerViewController alloc] init];
    self.window.contentView = _mainManager.view;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
    return YES;
}
     


@end
