//
//  AppDelegate.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/18/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AppDelegate.h"
#import "GroupModel.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    FMDBDataAccess *db = [FMDBDataAccess getInstance];
    [db getSchema];
    
    
    GroupModel *test = [GroupModel loadModel:4];
    NSLog( @"Test %@", test.name );
}


@end
