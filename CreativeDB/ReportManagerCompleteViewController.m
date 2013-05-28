//
//  ReportManagerCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ReportManagerCompleteViewController.h"
#import "BaseLayeredView.h"
#import "ScoreManagerListViewController.h"
#import "ScoreModel.h"

@interface ReportManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) ScoreManagerListViewController *scoreListManager;

@end

@implementation ReportManagerCompleteViewController

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
    NSDictionary *scoreListOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @"ScoreModel", MLE_FIELDSET_MODEL_KEY,
                                         [self packNSNull:nil], MLE_FIELDSET_MODEL_ITEM,
                                         nil];
    
    _scoreListManager = [[ScoreManagerListViewController alloc]
                            initWithOptions:scoreListOptions];
    
    _scoreListManager.view.frame = NSMakeRect( COMPLETE_VIEW_OFFSET_X,
                                                 0.0f,
                                                 COMPLETE_VIEW_CONTAINER_WIDTH,
                                                 COMPLETE_VIEW_CONTAINER_HEIGHT);
    
    [self.viewInstance addSubview:_scoreListManager.view];
    
}

@end
