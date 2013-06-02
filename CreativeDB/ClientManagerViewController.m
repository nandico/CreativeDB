//
//  ClientManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/23/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ClientManagerViewController.h"
#import "ClientModel.h"

@interface ClientManagerViewController ()

@property (nonatomic, strong) ClientManagerView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@end

@implementation ClientManagerViewController

- (id)initWithOptions:(NSDictionary *)options;
{
    self = [super init];
    if (self) {
        _options = options;
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_HEADERTITLE] )
            self.modelTitle = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_HEADERTITLE]];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_KEY] )
            self.modelName = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_KEY]];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM] )
            self.modelItem = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_ITEM]];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERNAME] )
            self.modelFilterName = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_FILTERNAME]];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE] )
            self.modelFilterValue = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE]];
        
        
        self.view = self.viewInstance = [[ClientManagerView alloc] init];
        self.viewInstance.dataSource = self;
        
        self.fieldData = [[NSMutableDictionary alloc] init];
        
        [self prepareEntity];
        
        [self.viewInstance createForm];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(saveAction)
                                                     name:MLE_NOTIFICATION_SAVE object:self.viewInstance.actionBar];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deleteAction)
                                                     name:MLE_NOTIFICATION_DELETE object:self.viewInstance.actionBar];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(newAction)
                                                     name:MLE_NOTIFICATION_NEW object:self.viewInstance.actionBar];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(nextAction)
                                                     name:MLE_NOTIFICATION_NEXT object:self.viewInstance.actionBar];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(previousAction)
                                                     name:MLE_NOTIFICATION_PREVIOUS object:self.viewInstance.actionBar];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateView:)
                                                     name:CLIENT_MANAGER_UPDATE_VIEW object:nil];
        
    }
    
    return self;
}

- (void) updateView:(NSNotification *) notification
{
    ClientModel *item = [notification.userInfo objectForKey:MLE_FIELDSET_MODEL_ITEM];
    
    if( item )
    {
        self.modelItem = item.pk;
        [self.viewInstance destroyForm];
        [self prepareEntity];
        [self.viewInstance createForm];
        
        [self updateClient];
    }
}

- (void) newAction
{
    [super newAction];
    [self updateClient];
    [self updateList];
}

- (void) nextAction
{
    [super nextAction];
    [self updateClient];
    [self updateList];
}

- (void) previousAction
{
    [super previousAction];
    [self updateClient];
    [self updateList];
}


- (void) saveAction
{
    [super saveAction];
    [self updateClient];
    [self updateList];
}

- (void) deleteAction
{
    [super deleteAction];
    [self updateList];
    [self updateClient];
}

- (void) updateClient
{
    NSDictionary *clientMessage;
    if( self.modelItem )
    {
        clientMessage = [NSDictionary dictionaryWithObject:self.modelItem forKey:MLE_FIELDSET_MODEL_FILTERVALUE];
    }
    else
    {
        clientMessage = [NSDictionary dictionaryWithObject:[NSNull null] forKey:MLE_FIELDSET_MODEL_FILTERVALUE];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CLIENT_MANAGER_UPDATE_CREDITS
                                                        object:self
                                                      userInfo:clientMessage];
}

- (void) updateList
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CLIENT_MANAGER_UPDATE_LIST
                                                        object:self
                                                      userInfo:nil];
    
}

- (void) prepareEntity
{
    NSDictionary *name = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInteger:MLETextFieldType], MLE_FIELD_TYPE_KEY,
                          @"name", MLE_FIELD_NAME_KEY,
                          @"Name", MLE_FIELD_LABEL_KEY,
                          [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                          [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                          [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                          [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                          nil];
    
    [self.fieldData setObject:name forKey:@"name"];
        
    NSDictionary *country = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                             @"country", MLE_FIELD_NAME_KEY,
                             @"Country", MLE_FIELD_LABEL_KEY,
                             @"CountryModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                             @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                             [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                             [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                             [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                             [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                             nil];
    
    [self.fieldData setObject:country forKey:@"country"];
}


@end
