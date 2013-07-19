//
//  ImportCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 7/18/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ImportCompleteViewController.h"
#import "BaseLayeredView.h"
#import "ManagerHeader.h"
#import "ManagerEngine.h"
#import "BaseManagerCompleteViewController.h"
#import "ImportViewController.h"

@interface ImportCompleteViewController()

@property (strong, nonatomic) BaseLayeredView *viewInstance;
@property (strong, nonatomic) ImportViewController *importCannes;

@property (strong, nonatomic) ManagerHeader *viewHeader;


@end

@implementation ImportCompleteViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view.layer.backgroundColor = [MLE_BACKGROUND_COLOR CGColor];
        [self createForm];
    }
    
    return self;
}

- (void) loadView
{
    self.view = self.viewInstance = [[BaseLayeredView alloc] init];
}

- (void) createForm
{
    _importCannes = [[ImportViewController alloc] init];
    _importCannes.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    _importCannes.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                               0,
                                               COMPLETE_VIEW_CONTAINER_WIDTH,
                                               COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    
    [self.viewInstance addSubview:_importCannes.view];

    
    
    NSDictionary *listHeaderOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"Import from Cannes Lions 2013", MLE_FIELDSET_MODEL_HEADERTITLE,
                                       nil];
    
    _viewHeader = [[ManagerHeader alloc] initWithOptions:listHeaderOptions];
    _viewHeader.frame = NSMakeRect(COMPLETE_VIEW_OFFSET_X + MLE_HEADER_OFFSET_X,
                                   COMPLETE_VIEW_CONTAINER_MEDIUMLIST_HEIGHT,
                                   _viewHeader.frame.size.width,
                                   _viewHeader.frame.size.height);
    [self.viewInstance addSubview:_viewHeader];
    
}


@end
