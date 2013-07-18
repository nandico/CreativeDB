//
//  ReportManagerCompleteViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ReportManagerCompleteViewController.h"
#import "BaseLayeredView.h"
#import "ScoreListViewController.h"
#import "ScoreModel.h"

@interface ReportManagerCompleteViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) ScoreListViewController *scoreListManager;

@property (nonatomic, strong) ManagerHeader *listHeader;

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
    
    _scoreListManager = [[ScoreListViewController alloc]
                            initWithOptions:scoreListOptions];
    
    
    _scoreListManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    [self.viewInstance addSubview:_scoreListManager.view];
    
    NSDictionary *listHeaderOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"Reports", MLE_FIELDSET_MODEL_HEADERTITLE,
                                       nil];
    
    _listHeader = [[ManagerHeader alloc] initWithOptions:listHeaderOptions];
    _listHeader.frame = NSMakeRect(COMPLETE_VIEW_OFFSET_X + MLE_HEADER_OFFSET_X,
                                   COMPLETE_VIEW_CONTAINER_MEDIUMLIST_HEIGHT,
                                   _listHeader.frame.size.width,
                                   _listHeader.frame.size.height);
    [self.viewInstance addSubview:_listHeader];
    
    NSLog( @"_listHeader: %f, %f", _listHeader.frame.origin.x, _listHeader.frame.origin.y );

}

@end
