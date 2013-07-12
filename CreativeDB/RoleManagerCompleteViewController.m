//
//  RoleManagerCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "RoleManagerCompleteViewController.h"
#import "BaseLayeredView.h"
#import "RoleManagerViewController.h"
#import "RoleManagerListViewController.h"
#import "RoleManagerViewController.h"
#import "ManagerEngine.h"
#import "RoleModel.h"

@interface RoleManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;

@property (nonatomic, strong) RoleManagerViewController *roleManager;
@property (nonatomic, strong) RoleManagerListViewController *roleListManager;


@end

@implementation RoleManagerCompleteViewController

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
    NSDictionary *roleOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"Roles", MLE_FIELDSET_MODEL_HEADERTITLE,
                                   @"RoleModel", MLE_FIELDSET_MODEL_KEY,
                                   [self packNSNull:[RoleModel first]], MLE_FIELDSET_MODEL_ITEM,
                                   nil];
    
    _roleManager = [[RoleManagerViewController alloc] initWithOptions:roleOptions];
    CGRect contentFrame = NSMakeRect( 10,
                                     277,
                                     COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH,
                                     COMPLETE_VIEW_CONTAINER_HEIGHT );
    _roleManager.view.frame = contentFrame;
    [self.viewInstance addSubview:_roleManager.view];
    
    NSDictionary *roleListOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"RoleModel", MLE_FIELDSET_MODEL_KEY,
                                       [self packNSNull:[RoleModel first]], MLE_FIELDSET_MODEL_ITEM,
                                       nil];
    
    _roleListManager = [[RoleManagerListViewController alloc]
                          initWithOptions:roleListOptions];
    
    _roleListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                               0,
                                               COMPLETE_VIEW_CONTAINER_WIDTH,
                                               COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    
    [self.viewInstance addSubview:_roleListManager.view positioned:NSWindowBelow relativeTo:_roleManager.view];
    
}

@end
