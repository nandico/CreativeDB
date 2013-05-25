//
//  PersonManagerCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonManagerCompleteViewController.h"
#import "BaseLayeredView.h"
#import "PersonModel.h"
#import "PersonManagerViewController.h"
#import "PersonManagerListViewController.h"

@interface PersonManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;

@property (nonatomic, strong) PersonManagerViewController *personManager;
@property (nonatomic, strong) PersonManagerListViewController *personListManager;

@end

@implementation PersonManagerCompleteViewController

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
    NSDictionary *personOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"PersonModel", MLE_FIELDSET_MODEL_KEY,
                                   [PersonModel first], MLE_FIELDSET_MODEL_ITEM,
                                   nil];
    
    _personManager = [[PersonManagerViewController alloc] initWithOptions:personOptions];
    CGRect contentFrame = NSMakeRect( 10,
                                     318,
                                     COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH,
                                     COMPLETE_VIEW_CONTAINER_HEIGHT );
    _personManager.view.frame = contentFrame;
    [self.viewInstance addSubview:_personManager.view];
    
    NSDictionary *personListOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"PersonModel", MLE_FIELDSET_MODEL_KEY,
                                       [PersonModel first], MLE_FIELDSET_MODEL_ITEM,
                                       nil];
    
    _personListManager = [[PersonManagerListViewController alloc]
                          initWithOptions:personListOptions];
    
    _personListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                               0,
                                               COMPLETE_VIEW_CONTAINER_WIDTH,
                                               COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    
    [self.viewInstance addSubview:_personListManager.view positioned:NSWindowBelow relativeTo:_personManager.view];
        
}

@end
