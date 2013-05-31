//
//  CategoryManagerCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/30/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CategoryManagerCompleteViewController.h"
#import "BaseLayeredView.h"
#import "CategoryManagerViewController.h"
#import "CategoryManagerListViewController.h"
#import "CategoryModel.h"

@interface CategoryManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) CategoryManagerViewController *categoryManager;
@property (nonatomic, strong) CategoryManagerListViewController *categoryListManager;

@end

@implementation CategoryManagerCompleteViewController

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
    NSDictionary *categoryOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"Categories", MLE_FIELDSET_MODEL_HEADERTITLE,
                                     @"CategoryModel", MLE_FIELDSET_MODEL_KEY,
                                     [self packNSNull:[CategoryModel first]], MLE_FIELDSET_MODEL_ITEM,
                                     nil];
    
    _categoryManager = [[CategoryManagerViewController alloc] initWithOptions:categoryOptions];
    CGRect contentFrame = NSMakeRect( 10,
                                     392,
                                     COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH,
                                     COMPLETE_VIEW_CONTAINER_HEIGHT );
    _categoryManager.view.frame = contentFrame;
    [self.viewInstance addSubview:_categoryManager.view];
    
    NSDictionary *categoryListOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @"CategoryModel", MLE_FIELDSET_MODEL_KEY,
                                         [self packNSNull:[CategoryModel first]], MLE_FIELDSET_MODEL_ITEM,
                                         nil];
    
    _categoryListManager = [[CategoryManagerListViewController alloc]
                            initWithOptions:categoryListOptions];
    
    _categoryListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                                 0,
                                                 COMPLETE_VIEW_CONTAINER_WIDTH,
                                                 COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    
    [self.viewInstance addSubview:_categoryListManager.view positioned:NSWindowBelow relativeTo:_categoryManager.view];
    
}


@end
