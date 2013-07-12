//
//  ProducerManagerCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/26/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProducerManagerCompleteViewController.h"
#import "BaseLayeredView.h"
#import "ProducerManagerViewController.h"
#import "ProducerManagerListViewController.h"
#import "ProducerModel.h"

@interface ProducerManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;

@property (nonatomic, strong) ProducerManagerViewController *producerManager;
@property (nonatomic, strong) ProducerManagerListViewController *producerListManager;


@end

@implementation ProducerManagerCompleteViewController

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
    NSDictionary *producerOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"Producer companies", MLE_FIELDSET_MODEL_HEADERTITLE,
                                 @"ProducerModel", MLE_FIELDSET_MODEL_KEY,
                                 [self packNSNull:[ProducerModel first]], MLE_FIELDSET_MODEL_ITEM,
                                 nil];
    
    _producerManager = [[ProducerManagerViewController alloc] initWithOptions:producerOptions];
    CGRect contentFrame = NSMakeRect( 10,
                                     319,
                                     COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH,
                                     COMPLETE_VIEW_CONTAINER_HEIGHT );
    _producerManager.view.frame = contentFrame;
    [self.viewInstance addSubview:_producerManager.view];
    
    NSDictionary *producerListOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"ProducerModel", MLE_FIELDSET_MODEL_KEY,
                                     [self packNSNull:[ProducerModel first]], MLE_FIELDSET_MODEL_ITEM,
                                     nil];
    
    _producerListManager = [[ProducerManagerListViewController alloc]
                        initWithOptions:producerListOptions];
    
    _producerListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                             0,
                                             COMPLETE_VIEW_CONTAINER_WIDTH,
                                             COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    
    [self.viewInstance addSubview:_producerListManager.view positioned:NSWindowBelow relativeTo:_producerManager.view];
    
}

@end
