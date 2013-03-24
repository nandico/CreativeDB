//
//  AppDelegate.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/18/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AppDelegate.h"

// tests
#import "GroupModel.h"
#import "CountryModel.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    FMDBDataAccess *db = [FMDBDataAccess getInstance];
    [db getSchema];
    
    
    GroupModel *group = [GroupModel loadModel:4];
    NSLog( @"Test %@", group.name );


    CountryModel *country = [CountryModel loadModel:1];
    NSLog( @"Test %@", country.name );
}


@end
