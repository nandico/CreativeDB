//
//  ClientManagerCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/23/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ClientManagerCompleteViewController.h"
#import "BaseLayeredView.h"
#import "ClientManagerViewController.h"
#import "ClientManagerListViewController.h"
#import "ClientModel.h"

@interface ClientManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;

@property (nonatomic, strong) ClientManagerViewController *clientManager;
@property (nonatomic, strong) ClientManagerListViewController *clientListManager;

@end

@implementation ClientManagerCompleteViewController

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
    NSDictionary *clientOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"ClientModel", MLE_FIELDSET_MODEL_KEY,
                                   [ClientModel first], MLE_FIELDSET_MODEL_ITEM,
                                   nil];
    
    _clientManager = [[ClientManagerViewController alloc] initWithOptions:clientOptions];
    CGRect contentFrame = NSMakeRect( 10,
                                     355,
                                     COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH,
                                     COMPLETE_VIEW_CONTAINER_HEIGHT );
    _clientManager.view.frame = contentFrame;
    [self.viewInstance addSubview:_clientManager.view];
    
    NSDictionary *clientListOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"ClientModel", MLE_FIELDSET_MODEL_KEY,
                                       [ClientModel first], MLE_FIELDSET_MODEL_ITEM,
                                       nil];
    
    _clientListManager = [[ClientManagerListViewController alloc]
                          initWithOptions:clientListOptions];
    
    _clientListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                               0,
                                               COMPLETE_VIEW_CONTAINER_WIDTH,
                                               COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    
    [self.viewInstance addSubview:_clientListManager.view positioned:NSWindowBelow relativeTo:_clientManager.view];
}

@end
