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
#import "ProductManagerViewController.h"
#import "ProductManagerListViewController.h"
#import "ClientModel.h"
#import "ProductModel.h"

@interface ClientManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;

@property (nonatomic, strong) ClientManagerViewController *clientManager;
@property (nonatomic, strong) ClientManagerListViewController *clientListManager;

@property (nonatomic, strong) ProductManagerViewController *productManager;
@property (nonatomic, strong) ProductManagerListViewController *productListManager;

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
                                   @"Clients", MLE_FIELDSET_MODEL_HEADERTITLE,
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
                                       [self packNSNull:[ClientModel first]], MLE_FIELDSET_MODEL_ITEM,
                                       nil];
    
    _clientListManager = [[ClientManagerListViewController alloc]
                          initWithOptions:clientListOptions];
    
    _clientListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                               0,
                                               COMPLETE_VIEW_CONTAINER_WIDTH,
                                               COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    
    [self.viewInstance addSubview:_clientListManager.view positioned:NSWindowBelow relativeTo:_clientManager.view];
    
    ProductModel.modelFilterName = @"client";
    ProductModel.modelFilterValue = [ClientModel first];

    NSDictionary *productOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Products for this client", MLE_FIELDSET_MODEL_HEADERTITLE,
                                    @"ProductModel", MLE_FIELDSET_MODEL_KEY,
                                   [self packNSNull:[ProductModel first]], MLE_FIELDSET_MODEL_ITEM,
                                    @"client", MLE_FIELDSET_MODEL_FILTERNAME,
                                    [self packNSNull:[ClientModel first]], MLE_FIELDSET_MODEL_FILTERVALUE,
                                   nil];
    
    _productManager = [[ProductManagerViewController alloc] initWithOptions:productOptions];
    
    _productManager.view.frame = NSMakeRect( ( COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH ),
                                            355,
                                            COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH,
                                            COMPLETE_VIEW_CONTAINER_HEIGHT );
    
    [self.viewInstance addSubview:_productManager.view];
    
    NSDictionary *productListOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"ProductModel", MLE_FIELDSET_MODEL_KEY,
                                       [self packNSNull:[ProductModel first]], MLE_FIELDSET_MODEL_ITEM,
                                        @"client", MLE_FIELDSET_MODEL_FILTERNAME,
                                        [self packNSNull:[ClientModel first]], MLE_FIELDSET_MODEL_FILTERVALUE,
                                       nil];
    
    _productListManager = [[ProductManagerListViewController alloc]
                          initWithOptions:productListOptions];
    
    _productListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH,
                                               0,
                                               ( COMPLETE_VIEW_CONTAINER_WIDTH ),
                                               COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    
    [self.viewInstance addSubview:_productListManager.view positioned:NSWindowBelow relativeTo:_clientManager.view];

}

@end
