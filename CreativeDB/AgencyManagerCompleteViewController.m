//
//  AgencyManagerCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/23/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AgencyManagerCompleteViewController.h"
#import "BaseLayeredView.h"
#import "AgencyManagerViewController.h"
#import "AgencyManagerListViewController.h"

@interface AgencyManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;

@property (nonatomic, strong) AgencyManagerViewController *agencyManager;
@property (nonatomic, strong) AgencyManagerListViewController *agencyListManager;

@end

@implementation AgencyManagerCompleteViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[BaseLayeredView alloc] init];
        self.view.layer.backgroundColor = [MLE_BACKGROUND_COLOR CGColor];
        
        [self createForm];
    }
    
    return self;
}

- (void) createForm
{
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
    [self.viewInstance addSubview:_agencyManager.view];
    
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
