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
#import "PersonDetailViewController.h"

@interface PersonManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;

@property (nonatomic, strong) PersonManagerViewController *personManager;
@property (nonatomic, strong) PersonManagerListViewController *personListManager;
@property (nonatomic, strong) PersonDetailViewController *personDetail;

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
    // COLUMN 0
    
    NSDictionary *personOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"Persons", MLE_FIELDSET_MODEL_HEADERTITLE,
                                   @"PersonModel", MLE_FIELDSET_MODEL_KEY,
                                   [self packNSNull:[PersonModel first]], MLE_FIELDSET_MODEL_ITEM,
                                   nil];
    
    _personManager = [[PersonManagerViewController alloc] initWithOptions:personOptions];
    CGRect contentFrame = NSMakeRect( 10,
                                     319,
                                     COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH,
                                     COMPLETE_VIEW_CONTAINER_HEIGHT );
    _personManager.view.frame = contentFrame;
    [self.viewInstance addSubview:_personManager.view];
    
    NSDictionary *personListOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"PersonModel", MLE_FIELDSET_MODEL_KEY,
                                       [self packNSNull:[PersonModel first]], MLE_FIELDSET_MODEL_ITEM,
                                       nil];
    
    _personListManager = [[PersonManagerListViewController alloc]
                          initWithOptions:personListOptions];
    
    _personListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                               0,
                                               COMPLETE_VIEW_CONTAINER_WIDTH,
                                               COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    
    [self.viewInstance addSubview:_personListManager.view positioned:NSWindowBelow relativeTo:_personManager.view];
    
    // COLUMN 1
    
    NSDictionary *personDetailOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"Persons", MLE_FIELDSET_MODEL_HEADERTITLE,
                                  @"PersonModel", MLE_FIELDSET_MODEL_KEY,
                                  [self packNSNull:[PersonModel first]], MLE_FIELDSET_MODEL_ITEM,
                                  nil];
    
    _personDetail = [[PersonDetailViewController alloc] initWithOptions:personDetailOptions];
    _personDetail.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH + COMPLETE_VIEW_OFFSET_X,
                                          COMPLETE_VIEW_OFFSET_Y,
                                          COMPLETE_VIEW_CONTAINER_WIDTH,
                                          COMPLETE_VIEW_CONTAINER_HEIGHT );
    [self.viewInstance addSubview:_personDetail.view positioned:NSWindowBelow relativeTo:_personListManager.view];
    
}

@end
