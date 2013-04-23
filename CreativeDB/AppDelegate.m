//
//  AppDelegate.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/18/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AppDelegate.h"

// temporary data
#import "ManagerEngine.h"

#import "AgencyManagerViewController.h"
#import "EntryManagerViewController.h"
#import "EntryModel.h"
#import "CreditModel.h"
#import "CreditManagerViewController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
//    NSDictionary *entryOptions = [NSDictionary dictionaryWithObjectsAndKeys:
//                                  @"EntryModel", MLE_FIELDSET_MODEL_KEY,
//                                  [EntryModel first], MLE_FIELDSET_MODEL_ITEM,
//                                  nil];
//    
//    EntryManagerViewController *entryManager = [[EntryManagerViewController alloc] initWithOptions:entryOptions];
//    entryManager.view.frame = self.window.frame;
//    entryManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
//    self.window.contentView = entryManager.view;
    
    
    
    
    NSDictionary *creditOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"CreditModel", MLE_FIELDSET_MODEL_KEY,
                                  [CreditModel first], MLE_FIELDSET_MODEL_ITEM,
                                  nil];
    
    CreditManagerViewController *creditManager = [[CreditManagerViewController alloc] initWithOptions:creditOptions];

    creditManager.view.frame = self.window.frame;
    creditManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    self.window.contentView = creditManager.view;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
    return YES;
}
     


@end
