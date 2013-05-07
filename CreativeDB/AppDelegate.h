//
//  AppDelegate.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/18/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FMDBDataAccess.h"
#import "EntryManagerCompleteViewController.h"


@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) EntryManagerCompleteViewController *entryManager;

@end
