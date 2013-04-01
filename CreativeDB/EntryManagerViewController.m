//
//  EntryManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/30/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryManagerViewController.h"
#import "EntryManagerView.h"
#import "ManagerEngine.h"
#import "EntryModel.h"

@interface EntryManagerViewController ()

@property (nonatomic, strong) EntryManagerView *entryView;
@property (nonatomic, strong) NSDictionary *options;

@end

@implementation EntryManagerViewController

- (id)initWithOptions:(NSDictionary *)options;
{
    self = [super init];
    if (self) {
        _options = options;
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_KEY] ) _modelName = [self.options objectForKey:MLE_FIELDSET_MODEL_KEY];
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM] ) _modelItem = [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM];
        
        self.view = self.entryView = [[EntryManagerView alloc] init];
        self.entryView.dataSource = self;
        [self.entryView createForm];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(saveAction)
                                                     name:MLE_NOTIFICATION_SAVE object:nil];
    }
    
    return self;
}

- (void) saveAction
{
    EntryModel *model = [EntryModel loadModel:_modelItem];

    NSLog( @"Model: %@", model );
}

@end
