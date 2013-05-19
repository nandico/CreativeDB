//
//  MainManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/19/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "MainManagerViewController.h"
#import "MainManagerView.h"
#import "EntryManagerCompleteViewController.h"
#import "MenuManagerViewController.h"

@interface MainManagerViewController ()

@property (nonatomic, strong) MainManagerView *viewInstance;
@property (nonatomic, strong) MenuManagerViewController *menuManager;
@property (nonatomic, strong) EntryManagerCompleteViewController *entryManager;


@end

@implementation MainManagerViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[MainManagerView alloc] init];
        [self prepareMain];
    }
    
    return self;
}

- (void) prepareMain
{
    _menuManager = [[MenuManagerViewController alloc] init];
    _menuManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.viewInstance addSubview:_menuManager.view];

    _entryManager = [[EntryManagerCompleteViewController alloc] init];
    _entryManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.viewInstance addSubview:_entryManager.view positioned:NSWindowBelow relativeTo:_menuManager.view];
    
    
}

@end
