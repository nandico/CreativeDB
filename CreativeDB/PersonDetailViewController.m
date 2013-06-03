//
//  PersonDetailViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/2/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "ManagerHeader.h"
#import "PersonDetailView.h"
#import "PersonManagerViewController.h"
#import "PersonModel.h"
#import "PersonEntryListViewController.h"

@interface PersonDetailViewController ()

@property (nonatomic, strong) PersonDetailView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) PersonModel *person;

@property (nonatomic, strong) PersonEntryListViewController *entryList;

@end

@implementation PersonDetailViewController

- (id)initWithOptions:(NSDictionary *) options
{
    self = [super init];
    if (self) {
        
        _options = options;
        
        self.view = self.viewInstance = [[PersonDetailView alloc] init];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM] )
            self.modelItem = [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateView:)
                                                     name:PERSON_MANAGER_UPDATE_VIEW object:nil];
        
        [self.viewInstance createForm];
        
        _entryList = [[PersonEntryListViewController alloc] initWithOptions:self.options];
        _entryList.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        [self.viewInstance addSubview:_entryList.view];
        
        [self updateView:nil];
    }
    
    return self;
}

- (void) updateView:(NSNotification *) notification
{
    if( notification )
    {
        _person = [notification.userInfo objectForKey:MLE_FIELDSET_MODEL_ITEM];
    }
    else if( self.modelItem )
    {
        _person = [PersonModel loadModel:self.modelItem];
    }
        
    if( _person )
    {
        [self.viewInstance.personName setStringValue:_person.name];
    }
}

@end
