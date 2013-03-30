//
//  AgencyManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AgencyManagerViewController.h"
#import "AgencyManagerView.h"
#import "ManagerEngine.h"


@interface AgencyManagerViewController ()

@property (nonatomic, strong) AgencyManagerView *agencyView;
@property (nonatomic, strong) NSDictionary *options;

@end

@implementation AgencyManagerViewController

- (id)initWithOptions:(NSDictionary *)options;
{
    self = [super init];
    if (self) {
        _options = options;
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_KEY] ) _modelName = [self.options objectForKey:MLE_FIELDSET_MODEL_KEY];
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM] ) _modelItem = [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM];

        self.view = self.agencyView = [[AgencyManagerView alloc] init];
        self.agencyView.dataSource = self;
        [self.agencyView createForm];
    }
    
    return self;
}

@end
