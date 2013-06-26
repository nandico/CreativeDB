//
//  GroupManagerCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/31/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "GroupManagerCompleteViewController.h"
#import "BaseLayeredView.h"
#import "GroupManagerViewController.h"
#import "GroupManagerListViewController.h"
#import "GroupModel.h"

@interface GroupManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) GroupManagerViewController *groupManager;
@property (nonatomic, strong) GroupManagerListViewController *groupListManager;

@end

@implementation GroupManagerCompleteViewController

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
    NSDictionary *groupOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"Groups", MLE_FIELDSET_MODEL_HEADERTITLE,
                                        @"GroupModel", MLE_FIELDSET_MODEL_KEY,
                                        [self packNSNull:[GroupModel first]], MLE_FIELDSET_MODEL_ITEM,
                                        nil];
    
    _groupManager = [[GroupManagerViewController alloc] initWithOptions:groupOptions];
    CGRect contentFrame = NSMakeRect( 10,
                                     355,
                                     COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH,
                                     COMPLETE_VIEW_CONTAINER_HEIGHT );
    _groupManager.view.frame = contentFrame;
    [self.viewInstance addSubview:_groupManager.view];
    
    NSDictionary *groupListOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                            @"GroupModel", MLE_FIELDSET_MODEL_KEY,
                                            [self packNSNull:[GroupModel first]], MLE_FIELDSET_MODEL_ITEM,
                                            nil];
    
    _groupListManager = [[GroupManagerListViewController alloc]
                               initWithOptions:groupListOptions];
    
    _groupListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                                    0,
                                                    COMPLETE_VIEW_CONTAINER_WIDTH,
                                                    COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    
    [self.viewInstance addSubview:_groupListManager.view positioned:NSWindowBelow relativeTo:_groupManager.view];
    
}


@end
