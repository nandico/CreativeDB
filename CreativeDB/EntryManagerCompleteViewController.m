//
//  EntryManagerCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 4/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryManagerCompleteViewController.h"
#import "EntryManagerCompleteView.h"
#import "CreditManagerListViewController.h"
#import "ProducerCreditManagerViewController.h"
#import "ProducerCreditManagerListViewController.h"
#import "EntryManagerCompleteScrollView.h"

#import "EntryModel.h"
#import "CreditModel.h"
#import "ProducerCreditModel.h"

@interface EntryManagerCompleteViewController ()

@property (nonatomic, strong) EntryManagerCompleteView *viewInstance;

@property (nonatomic, strong) EntryManagerViewController *entryManager;
@property (nonatomic, strong) CreditManagerViewController *creditManager;
@property (nonatomic, strong) CreditManagerListViewController *creditListManager;
@property (nonatomic, strong) ProducerCreditManagerViewController *producerCreditManager;
@property (nonatomic, strong) ProducerCreditManagerListViewController *producerCreditListManager;
@property (nonatomic, strong) EntryManagerCompleteScrollView *completeScrollView;

@end

@implementation EntryManagerCompleteViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[EntryManagerCompleteView alloc] init];
        
        [self createForm];
    }
    
    return self;
}

- (void) createForm
{
    _completeScrollView = [[EntryManagerCompleteScrollView alloc] init];
    _completeScrollView.frame = self.view.bounds;
    _completeScrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [_completeScrollView setHasVerticalScroller:YES];
    [_completeScrollView setHasVerticalRuler:YES];
    [_completeScrollView setHasHorizontalScroller:YES];
    [_completeScrollView setHasHorizontalRuler:YES];
    [_completeScrollView setPostsBoundsChangedNotifications:YES];
    
    [self.view addSubview:_completeScrollView];

        
    NSDictionary *entryOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"EntryModel", MLE_FIELDSET_MODEL_KEY,
                                  [EntryModel first], MLE_FIELDSET_MODEL_ITEM,
                                  nil];
    
    _entryManager = [[EntryManagerViewController alloc] initWithOptions:entryOptions];
    _entryManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                          COMPLETE_VIEW_OFFSET_Y,
                                          COMPLETE_VIEW_CONTAINER_WIDTH,
                                          COMPLETE_VIEW_CONTAINER_HEIGHT );
    [_completeScrollView.contentView addSubview:_entryManager.view];
    
    CreditModel.modelFilterName = @"entry";
    CreditModel.modelFilterValue = [EntryModel first];
    
    NSDictionary *creditOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"CreditModel", MLE_FIELDSET_MODEL_KEY,
                                   [CreditModel first], MLE_FIELDSET_MODEL_ITEM,
                                   @"entry", MLE_FIELDSET_MODEL_FILTERNAME,
                                   [EntryModel first], MLE_FIELDSET_MODEL_FILTERVALUE,
                                   nil];
    
    _creditManager = [[CreditManagerViewController alloc] initWithOptions:creditOptions];
    _creditManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH,
                                           COMPLETE_VIEW_OFFSET_Y + 298.0f,
                                           COMPLETE_VIEW_CONTAINER_WIDTH,
                                           COMPLETE_VIEW_CONTAINER_HEIGHT );
    [_completeScrollView.contentView addSubview:_creditManager.view];
    
    
    NSDictionary *entryCreditOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"CreditModel", MLE_FIELDSET_MODEL_KEY,
                                        [CreditModel first], MLE_FIELDSET_MODEL_ITEM,
                                        @"entry", MLE_FIELDSET_MODEL_FILTERNAME,
                                        [EntryModel first], MLE_FIELDSET_MODEL_FILTERVALUE,
                                        nil];
    
    _creditListManager = [[CreditManagerListViewController alloc]
                                                          initWithOptions:entryCreditOptions];
    _creditListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_WIDTH,
                                               COMPLETE_VIEW_OFFSET_Y + 20.0f,
                                               COMPLETE_VIEW_CONTAINER_WIDTH,
                                               COMPLETE_VIEW_CONTAINER_HEIGHT );
    [_completeScrollView.contentView addSubview:_creditListManager.view];
    
    
    ProducerCreditModel.modelFilterName = @"entry";
    ProducerCreditModel.modelFilterValue = [EntryModel first];
    
    NSDictionary *producerCreditOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"ProducerCreditModel", MLE_FIELDSET_MODEL_KEY,
                                   [ProducerCreditModel first], MLE_FIELDSET_MODEL_ITEM,
                                   @"entry", MLE_FIELDSET_MODEL_FILTERNAME,
                                   [EntryModel first], MLE_FIELDSET_MODEL_FILTERVALUE,
                                   nil];
    
    _producerCreditManager = [[ProducerCreditManagerViewController alloc] initWithOptions:producerCreditOptions];
    _producerCreditManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X + ( COMPLETE_VIEW_CONTAINER_WIDTH * 2 ),
                                                   COMPLETE_VIEW_OFFSET_Y + 298.0f,
                                                   COMPLETE_VIEW_CONTAINER_WIDTH,
                                                   COMPLETE_VIEW_CONTAINER_HEIGHT );
    [_completeScrollView.contentView addSubview:_producerCreditManager.view];
    
    
    NSDictionary *producerEntryCreditOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"ProducerCreditModel", MLE_FIELDSET_MODEL_KEY,
                                        [ProducerCreditModel first], MLE_FIELDSET_MODEL_ITEM,
                                        @"entry", MLE_FIELDSET_MODEL_FILTERNAME,
                                        [EntryModel first], MLE_FIELDSET_MODEL_FILTERVALUE,
                                        nil];
    
    _producerCreditListManager = [[ProducerCreditManagerListViewController alloc]
                          initWithOptions:producerEntryCreditOptions];
    _producerCreditListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X + ( COMPLETE_VIEW_CONTAINER_WIDTH * 2 ),
                                                       COMPLETE_VIEW_OFFSET_Y + 20.0f,
                                                       COMPLETE_VIEW_CONTAINER_WIDTH,
                                                       COMPLETE_VIEW_CONTAINER_HEIGHT);
    [_completeScrollView.contentView addSubview:_producerCreditListManager.view];

}

- (BOOL) acceptsFirstResponder
{
    return YES;
}

@end
