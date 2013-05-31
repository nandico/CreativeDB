//
//  SubcategoryManagerCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/30/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "SubcategoryManagerCompleteViewController.h"
#import "BaseLayeredView.h"
#import "SubcategoryManagerViewController.h"
#import "SubcategoryManagerListViewController.h"
#import "SubcategoryModel.h"

@interface SubcategoryManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) SubcategoryManagerViewController *subcategoryManager;
@property (nonatomic, strong) SubcategoryManagerListViewController *subcategoryListManager;

@end

@implementation SubcategoryManagerCompleteViewController

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
    NSDictionary *subcategoryOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"Subcategories", MLE_FIELDSET_MODEL_HEADERTITLE,
                                     @"SubcategoryModel", MLE_FIELDSET_MODEL_KEY,
                                     [self packNSNull:[SubcategoryModel first]], MLE_FIELDSET_MODEL_ITEM,
                                     nil];
    
    _subcategoryManager = [[SubcategoryManagerViewController alloc] initWithOptions:subcategoryOptions];
    CGRect contentFrame = NSMakeRect( 10,
                                     392,
                                     COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH,
                                     COMPLETE_VIEW_CONTAINER_HEIGHT );
    _subcategoryManager.view.frame = contentFrame;
    [self.viewInstance addSubview:_subcategoryManager.view];
    
    NSDictionary *subcategoryListOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @"SubcategoryModel", MLE_FIELDSET_MODEL_KEY,
                                         [self packNSNull:[SubcategoryModel first]], MLE_FIELDSET_MODEL_ITEM,
                                         nil];
    
    _subcategoryListManager = [[SubcategoryManagerListViewController alloc]
                            initWithOptions:subcategoryListOptions];
    
    _subcategoryListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                                 0,
                                                 COMPLETE_VIEW_CONTAINER_WIDTH,
                                                 COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    
    [self.viewInstance addSubview:_subcategoryListManager.view positioned:NSWindowBelow relativeTo:_subcategoryManager.view];
    
}


@end
