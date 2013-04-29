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
#import "EntryModel.h"
#import "CreditModel.h"

@interface EntryManagerCompleteViewController ()

@property (nonatomic, strong) EntryManagerCompleteView *viewInstance;

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
    NSDictionary *entryOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"EntryModel", MLE_FIELDSET_MODEL_KEY,
                                  [EntryModel first], MLE_FIELDSET_MODEL_ITEM,
                                  nil];
    
    EntryManagerViewController *entryManager = [[EntryManagerViewController alloc] initWithOptions:entryOptions];
    entryManager.view.frame = NSMakeRect(0, 0, 500, 500);
    [self.view addSubview:entryManager.view];
    
    
    
    NSDictionary *creditOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"CreditModel", MLE_FIELDSET_MODEL_KEY,
                                   [CreditModel first], MLE_FIELDSET_MODEL_ITEM,
                                   nil];
    
    CreditManagerViewController *creditManager = [[CreditManagerViewController alloc] initWithOptions:creditOptions];
    creditManager.view.frame = NSMakeRect(500, 0, 500, 500);
    [self.view addSubview:creditManager.view];
    
    
    
    CreditManagerListViewController *creditListManager = [[CreditManagerListViewController alloc] init];
    creditListManager.view.frame = NSMakeRect(1000, 0, 500, 500);
    [self.view addSubview:creditListManager.view];
    
    
    


}

@end
