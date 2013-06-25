//
//  EntryManagerCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 4/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryManagerCompleteViewController.h"
#import "BaseLayeredView.h"
#import "EntryManagerCompleteScrollView.h"
#import "CreditManagerListViewController.h"
#import "ProducerCreditManagerViewController.h"
#import "ProducerCreditManagerListViewController.h"
#import "AwardManagerViewController.h"
#import "AwardManagerListViewController.h"
#import "EntryManagerListViewController.h"
#import "BaseLayeredView.h"
#import "ManagerHeader.h"


#import "EntryModel.h"
#import "CreditModel.h"
#import "ProducerCreditModel.h"
#import "AwardModel.h"

@interface EntryManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;

@property (nonatomic, strong) EntryManagerListViewController *entryListManager;
@property (nonatomic, strong) EntryManagerViewController *entryManager;
@property (nonatomic, strong) CreditManagerViewController *creditManager;
@property (nonatomic, strong) CreditManagerListViewController *creditListManager;
@property (nonatomic, strong) ProducerCreditManagerViewController *producerCreditManager;
@property (nonatomic, strong) ProducerCreditManagerListViewController *producerCreditListManager;
@property (nonatomic, strong) AwardManagerViewController *awardManager;
@property (nonatomic, strong) AwardManagerListViewController *awardListManager;
@property (nonatomic, strong) EntryManagerCompleteScrollView *scrollView;
@property (nonatomic, strong) BaseLayeredView *scrollContent;

@property (nonatomic, strong) ManagerHeader *entryListHeader;

@end

@implementation EntryManagerCompleteViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[BaseLayeredView alloc] init];
        
        [self createForm];
    }
    
    return self;
}

- (void) createForm
{
    CGRect contentFrame = NSMakeRect( 0,
                                     0,
                                     COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH + COMPLETE_VIEW_OFFSET_X + ( COMPLETE_VIEW_CONTAINER_WIDTH * 4 ),
                                     COMPLETE_VIEW_CONTAINER_HEIGHT );

    
    _scrollContent = [[BaseLayeredView alloc] initWithFrame:contentFrame];

    // COLUMN 0

    NSDictionary *entryListHeaderOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"Entries list", MLE_FIELDSET_MODEL_HEADERTITLE,
                                   nil];
    
    _entryListHeader = [[ManagerHeader alloc] initWithOptions:entryListHeaderOptions];
    _entryListHeader.frame = NSMakeRect(COMPLETE_VIEW_OFFSET_X,
                                        COMPLETE_VIEW_CONTAINER_MEDIUMLIST_HEIGHT + 7.0f,
                                        _entryListHeader.frame.size.width,
                                        _entryListHeader.frame.size.height);
    [_scrollContent addSubview:_entryListHeader];
    
    NSDictionary *entryListOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"EntryModel", MLE_FIELDSET_MODEL_KEY,
                                      [self packNSNull:[EntryModel first]], MLE_FIELDSET_MODEL_ITEM,
                                      nil];
    
    _entryListManager = [[EntryManagerListViewController alloc]
                         initWithOptions:entryListOptions];
    _entryListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                              0,
                                              COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH,
                                              COMPLETE_VIEW_CONTAINER_MEDIUMLIST_HEIGHT);
    [_scrollContent addSubview:_entryListManager.view positioned:NSWindowBelow relativeTo:_entryListHeader];
    
        
    // COLUMN 1
    
    NSDictionary *entryOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"Entries", MLE_FIELDSET_MODEL_HEADERTITLE,
                                  @"EntryModel", MLE_FIELDSET_MODEL_KEY,
                                  [self packNSNull:[EntryModel first]], MLE_FIELDSET_MODEL_ITEM,
                                  nil];
    
    _entryManager = [[EntryManagerViewController alloc] initWithOptions:entryOptions];
    _entryManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH + COMPLETE_VIEW_OFFSET_X,
                                          COMPLETE_VIEW_OFFSET_Y,
                                          COMPLETE_VIEW_CONTAINER_WIDTH,
                                          COMPLETE_VIEW_CONTAINER_HEIGHT );
    [_scrollContent addSubview:_entryManager.view];
    
    AwardModel.modelFilterName = @"entry";
    AwardModel.modelFilterValue = [EntryModel first];
    
    // COLUMN 2
    
    NSDictionary *awardOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"Awards", MLE_FIELDSET_MODEL_HEADERTITLE,
                                  @"AwardModel", MLE_FIELDSET_MODEL_KEY,
                                  [self packNSNull:[AwardModel first]], MLE_FIELDSET_MODEL_ITEM,
                                  @"entry", MLE_FIELDSET_MODEL_FILTERNAME,
                                  [self packNSNull:[EntryModel first]], MLE_FIELDSET_MODEL_FILTERVALUE,
                                  nil];
    
    _awardManager = [[AwardManagerViewController alloc] initWithOptions:awardOptions];
    _awardManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH + COMPLETE_VIEW_OFFSET_X + ( COMPLETE_VIEW_CONTAINER_WIDTH  ),
                                          COMPLETE_VIEW_OFFSET_Y + 187.0f,
                                          COMPLETE_VIEW_CONTAINER_WIDTH,
                                          COMPLETE_VIEW_CONTAINER_HEIGHT );
    [_scrollContent addSubview:_awardManager.view];
    
    
    NSDictionary *awardListOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"AwardModel", MLE_FIELDSET_MODEL_KEY,
                                      [self packNSNull:[AwardModel first]], MLE_FIELDSET_MODEL_ITEM,
                                      @"entry", MLE_FIELDSET_MODEL_FILTERNAME,
                                      [self packNSNull:[EntryModel first]], MLE_FIELDSET_MODEL_FILTERVALUE,
                                      nil];
    
    _awardListManager = [[AwardManagerListViewController alloc]
                         initWithOptions:awardListOptions];
    _awardListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH + COMPLETE_VIEW_OFFSET_X + ( COMPLETE_VIEW_CONTAINER_WIDTH ),
                                              0,
                                              COMPLETE_VIEW_CONTAINER_WIDTH,
                                              COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    [_scrollContent addSubview:_awardListManager.view];
    
    
    CreditModel.modelFilterName = @"entry";
    CreditModel.modelFilterValue = [EntryModel first];
    
    // COLUMN 3
    
    NSDictionary *creditOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"Credits", MLE_FIELDSET_MODEL_HEADERTITLE,
                                   @"CreditModel", MLE_FIELDSET_MODEL_KEY,
                                   [self packNSNull:[CreditModel first]], MLE_FIELDSET_MODEL_ITEM,
                                   @"entry", MLE_FIELDSET_MODEL_FILTERNAME,
                                   [self packNSNull:[EntryModel first]], MLE_FIELDSET_MODEL_FILTERVALUE,
                                   nil];
    
    _creditManager = [[CreditManagerViewController alloc] initWithOptions:creditOptions];
    _creditManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH + COMPLETE_VIEW_OFFSET_X + ( COMPLETE_VIEW_CONTAINER_WIDTH * 2 ),
                                           COMPLETE_VIEW_OFFSET_Y + 261.0f,
                                           COMPLETE_VIEW_CONTAINER_WIDTH,
                                           COMPLETE_VIEW_CONTAINER_HEIGHT );
    [_scrollContent addSubview:_creditManager.view];
    
    
    NSDictionary *entryCreditOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"CreditModel", MLE_FIELDSET_MODEL_KEY,
                                        [self packNSNull:[CreditModel first]], MLE_FIELDSET_MODEL_ITEM,
                                        @"entry", MLE_FIELDSET_MODEL_FILTERNAME,
                                        [self packNSNull:[EntryModel first]], MLE_FIELDSET_MODEL_FILTERVALUE,
                                        nil];
    
    _creditListManager = [[CreditManagerListViewController alloc]
                                                          initWithOptions:entryCreditOptions];
    _creditListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH + COMPLETE_VIEW_OFFSET_X + ( COMPLETE_VIEW_CONTAINER_WIDTH * 2 ),
                                               0,
                                               COMPLETE_VIEW_CONTAINER_WIDTH,
                                               COMPLETE_VIEW_CONTAINER_LIST_HEIGHT );
    [_scrollContent addSubview:_creditListManager.view];
    
    
    ProducerCreditModel.modelFilterName = @"entry";
    ProducerCreditModel.modelFilterValue = [EntryModel first];
    
    // COLUMN 4
    
    NSDictionary *producerCreditOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"Producer company credits", MLE_FIELDSET_MODEL_HEADERTITLE,
                                   @"ProducerCreditModel", MLE_FIELDSET_MODEL_KEY,
                                   [self packNSNull:[ProducerCreditModel first]], MLE_FIELDSET_MODEL_ITEM,
                                   @"entry", MLE_FIELDSET_MODEL_FILTERNAME,
                                   [self packNSNull:[EntryModel first]], MLE_FIELDSET_MODEL_FILTERVALUE,
                                   nil];
    
    _producerCreditManager = [[ProducerCreditManagerViewController alloc] initWithOptions:producerCreditOptions];
    _producerCreditManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH + COMPLETE_VIEW_OFFSET_X + ( COMPLETE_VIEW_CONTAINER_WIDTH * 3 ),
                                                   COMPLETE_VIEW_OFFSET_Y + 298.0f,
                                                   COMPLETE_VIEW_CONTAINER_WIDTH,
                                                   COMPLETE_VIEW_CONTAINER_HEIGHT );
    [_scrollContent addSubview:_producerCreditManager.view];
    
    
    NSDictionary *producerEntryCreditOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"ProducerCreditModel", MLE_FIELDSET_MODEL_KEY,
                                        [self packNSNull:[ProducerCreditModel first]], MLE_FIELDSET_MODEL_ITEM,
                                        @"entry", MLE_FIELDSET_MODEL_FILTERNAME,
                                        [self packNSNull:[EntryModel first]], MLE_FIELDSET_MODEL_FILTERVALUE,
                                        nil];

    _producerCreditListManager = [[ProducerCreditManagerListViewController alloc]
                          initWithOptions:producerEntryCreditOptions];
    _producerCreditListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X + COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH + COMPLETE_VIEW_OFFSET_X + ( COMPLETE_VIEW_CONTAINER_WIDTH * 3 ),
                                                       0,
                                                       COMPLETE_VIEW_CONTAINER_WIDTH,
                                                       COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
    [_scrollContent addSubview:_producerCreditListManager.view];
        
    
    _scrollView = [[EntryManagerCompleteScrollView alloc] init];
    _scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    [_scrollView setHasHorizontalScroller:YES];
    [_scrollView setHasVerticalScroller:NO];
    [_scrollView setDocumentView:_scrollContent];
    [_scrollView setHasVerticalScroller:YES];
    [_scrollView setHasVerticalRuler:YES];
    [_scrollView setPostsBoundsChangedNotifications:YES];
    [_scrollView setScrollerStyle:NSScrollerStyleOverlay];
    
    [self.viewInstance addSubview:_scrollView];
}

- (BOOL) acceptsFirstResponder
{
    return YES;
}

@end
