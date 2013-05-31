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
#import "AgencyManagerCompleteViewController.h"
#import "ClientManagerCompleteViewController.h"
#import "PersonManagerCompleteViewController.h"
#import "RoleManagerCompleteViewController.h"
#import "ProducerManagerCompleteViewController.h"
#import "CategoryManagerCompleteViewController.h"
#import "SubcategoryManagerCompleteViewController.h"
#import "ReportManagerCompleteViewController.h"

@interface MainManagerViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) MenuManagerViewController *menuManager;
@property (nonatomic, strong) EntryManagerCompleteViewController *entryManager;
@property (nonatomic, strong) AgencyManagerCompleteViewController *agencyManager;
@property (nonatomic, strong) ClientManagerCompleteViewController *clientManager;
@property (nonatomic, strong) PersonManagerCompleteViewController *personManager;
@property (nonatomic, strong) RoleManagerCompleteViewController *roleManager;
@property (nonatomic, strong) ProducerManagerCompleteViewController *producerManager;
@property (nonatomic, strong) CategoryManagerCompleteViewController *categoryManager;
@property (nonatomic, strong) SubcategoryManagerCompleteViewController *subcategoryManager;
@property (nonatomic, strong) ReportManagerCompleteViewController *reportsManager;

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
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showPersons)
                                                     name:MENU_PERSONS object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showRoles)
                                                     name:MENU_ROLES object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showProducers)
                                                     name:MENU_PRODUCERS object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showCategories)
                                                     name:MENU_CATEGORIES object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showSubcategories)
                                                     name:MENU_SUBCATEGORIES object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showReports)
                                                     name:MENU_REPORTS object:nil];
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

- (void) showPersons
{
    [self hideAll];
    [_personManager.view setHidden:NO];
}

- (void) showRoles
{
    [self hideAll];
    [_roleManager.view setHidden:NO];
}

- (void) showProducers
{
    [self hideAll];
    [_producerManager.view setHidden:NO];
}

- (void) showCategories
{
    [self hideAll];
    [_categoryManager.view setHidden:NO];
}

- (void) showSubcategories
{
    [self hideAll];
    [_subcategoryManager.view setHidden:NO];
}

- (void) showReports
{
    [self hideAll];
    [_reportsManager.view setHidden:NO];
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
    
    _personManager = [[PersonManagerCompleteViewController alloc] init];
    _personManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.viewInstance addSubview:_personManager.view positioned:NSWindowBelow relativeTo:_clientManager.view];
    [_personManager.view setHidden:YES];
    [_modules setObject:_personManager forKey:MENU_PERSONS];
    
    _roleManager = [[RoleManagerCompleteViewController alloc] init];
    _roleManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.viewInstance addSubview:_roleManager.view positioned:NSWindowBelow relativeTo:_personManager.view];
    [_roleManager.view setHidden:YES];
    [_modules setObject:_roleManager forKey:MENU_ROLES];
    
    _producerManager = [[ProducerManagerCompleteViewController alloc] init];
    _producerManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.viewInstance addSubview:_producerManager.view positioned:NSWindowBelow relativeTo:_roleManager.view];
    [_producerManager.view setHidden:YES];
    [_modules setObject:_producerManager forKey:MENU_PRODUCERS];
    
    _categoryManager = [[CategoryManagerCompleteViewController alloc] init];
    _categoryManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.viewInstance addSubview:_categoryManager.view positioned:NSWindowBelow relativeTo:_producerManager.view];
    [_categoryManager.view setHidden:YES];
    [_modules setObject:_categoryManager forKey:MENU_CATEGORIES];
    
    _subcategoryManager = [[SubcategoryManagerCompleteViewController alloc] init];
    _subcategoryManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.viewInstance addSubview:_subcategoryManager.view positioned:NSWindowBelow relativeTo:_categoryManager.view];
    [_subcategoryManager.view setHidden:YES];
    [_modules setObject:_subcategoryManager forKey:MENU_SUBCATEGORIES];
    
    _reportsManager = [[ReportManagerCompleteViewController alloc] init];
    _reportsManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.viewInstance addSubview:_reportsManager.view positioned:NSWindowBelow relativeTo:_producerManager.view];
    [_reportsManager.view setHidden:YES];
    [_modules setObject:_reportsManager forKey:MENU_REPORTS];
}

@end
