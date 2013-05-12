//
//  AppDelegate.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/18/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AppDelegate.h"
#import "AgencyManagerViewController.h"

#import "AgencyModel.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _entryManager = [[EntryManagerCompleteViewController alloc] init];
    self.window.contentView = _entryManager.view;
    

//    NSDictionary *agencyOptions = [NSDictionary dictionaryWithObjectsAndKeys:
//                                  @"AgencyModel", MLE_FIELDSET_MODEL_KEY,
//                                  [AgencyModel first], MLE_FIELDSET_MODEL_ITEM,
//                                  nil];
//    
//    AgencyManagerViewController *agencyManager = [[AgencyManagerViewController alloc] initWithOptions:agencyOptions];
//    agencyManager.view.frame = NSMakeRect(0, 0, 500, 500);
//    self.window.contentView = agencyManager.view;
//
     
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
    return YES;
}
     


@end
