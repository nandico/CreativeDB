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
#import "AgencyManagerViewController.h"
#import "AgencyManagerListViewController.h"

@interface MainManagerViewController ()

@property (nonatomic, strong) MainManagerView *viewInstance;
@property (nonatomic, strong) MenuManagerViewController *menuManager;
@property (nonatomic, strong) EntryManagerCompleteViewController *entryManager;
@property (nonatomic, strong) AgencyManagerViewController *agencyManager;
@property (nonatomic, strong) AgencyManagerListViewController *agencyListManager;


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
    //[self.viewInstance addSubview:_entryManager.view positioned:NSWindowBelow relativeTo:_menuManager.view];
    
    NSDictionary *agencyOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"AgencyModel", MLE_FIELDSET_MODEL_KEY,
                                  [AgencyModel first], MLE_FIELDSET_MODEL_ITEM,
                                  nil];

    _agencyManager = [[AgencyManagerViewController alloc] initWithOptions:agencyOptions];
    CGRect contentFrame = NSMakeRect( 10,
                                     318,
                                     COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH,
                                     COMPLETE_VIEW_CONTAINER_HEIGHT );
    _agencyManager.view.frame = contentFrame;
    [self.viewInstance addSubview:_agencyManager.view positioned:NSWindowAbove relativeTo:_entryManager.view];
    
    NSDictionary *agencyListOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                                @"AgencyModel", MLE_FIELDSET_MODEL_KEY,
                                                [AgencyModel first], MLE_FIELDSET_MODEL_ITEM,
                                                nil];
    
    _agencyListManager = [[AgencyManagerListViewController alloc]
                                  initWithOptions:agencyListOptions];
    //_agencyListManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    _agencyListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                                       0,
                                                       COMPLETE_VIEW_CONTAINER_WIDTH,
                                                       COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    
    [self.viewInstance addSubview:_agencyListManager.view positioned:NSWindowBelow relativeTo:_agencyManager.view];
 
}

@end
