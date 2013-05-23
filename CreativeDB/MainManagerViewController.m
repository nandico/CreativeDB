//
//  MainManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/19/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "MainManagerViewController.h"
#import "BaseLayeredView.h"
#import "EntryManagerCompleteViewController.h"
#import "MenuManagerViewController.h"
#import "AgencyManagerViewController.h"
#import "AgencyManagerListViewController.h"
#import "AgencyManagerCompleteViewController.h"
#import "ClientManagerCompleteViewController.h"

@interface MainManagerViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) MenuManagerViewController *menuManager;
@property (nonatomic, strong) EntryManagerCompleteViewController *entryManager;
@property (nonatomic, strong) AgencyManagerCompleteViewController *agencyManager;
@property (nonatomic, strong) ClientManagerCompleteViewController *clientManager;

@property (nonatomic, strong) NSMutableDictionary *modules;

@end

@implementation MainManagerViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[BaseLayeredView alloc] init];
        [self prepareMain];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showEntries)
                                                     name:MENU_ENTRIES object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showAgencies)
                                                     name:MENU_AGENCIES object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showClients)
                                                     name:MENU_CLIENTS object:nil];
    }
    
    return self;
}

- (void) hideAll
{
    for( NSString *moduleName in _modules )
    {
        NSViewController *module = [_modules objectForKey:moduleName];
        [module.view setHidden:YES];
    }
}

- (void) showEntries
{
    [self hideAll];
    [_entryManager.view setHidden:NO];
}

- (void) showAgencies
{
    [self hideAll];
    [_agencyManager.view setHidden:NO];
}

- (void) showClients
{
    [self hideAll];
    [_clientManager.view setHidden:NO];
}


- (void) prepareMain
{
    _modules = [[NSMutableDictionary alloc] init];
    
    _menuManager = [[MenuManagerViewController alloc] init];
    _menuManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.viewInstance addSubview:_menuManager.view];
    
    _entryManager = [[EntryManagerCompleteViewController alloc] init];
    _entryManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.viewInstance addSubview:_entryManager.view positioned:NSWindowBelow relativeTo:_menuManager.view];
    [_entryManager.view setHidden:NO];
    [_modules setObject:_entryManager forKey:MENU_ENTRIES];
    
    _agencyManager = [[AgencyManagerCompleteViewController alloc] init];
    _agencyManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.viewInstance addSubview:_agencyManager.view positioned:NSWindowBelow relativeTo:_entryManager.view];
    [_agencyManager.view setHidden:YES];
    [_modules setObject:_agencyManager forKey:MENU_AGENCIES];

    _clientManager = [[ClientManagerCompleteViewController alloc] init];
    _clientManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.viewInstance addSubview:_clientManager.view positioned:NSWindowBelow relativeTo:_agencyManager.view];
    [_clientManager.view setHidden:YES];
    [_modules setObject:_clientManager forKey:MENU_CLIENTS];
}

@end
