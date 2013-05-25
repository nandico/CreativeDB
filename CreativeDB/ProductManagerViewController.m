//
//  ProductManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/23/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProductManagerViewController.h"
#import "ClientManagerViewController.h"
#import "ProductModel.h"

@interface ProductManagerViewController ()

@property (nonatomic, strong) ProductManagerView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@end

@implementation ProductManagerViewController

- (id)initWithOptions:(NSDictionary *)options;
{
    self = [super init];
    if (self) {
        _options = options;
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_KEY] )
            self.modelName = [self.options objectForKey:MLE_FIELDSET_MODEL_KEY];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM] )
            self.modelItem = [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERNAME] )
            self.modelFilterName = [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERNAME];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE] )
            self.modelFilterValue = [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE];
        
        
        self.view = self.viewInstance = [[ProductManagerView alloc] init];
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
                                                 selector:@selector(updateClient:)
                                                     name:CLIENT_MANAGER_UPDATE_CREDITS object:nil];
        
        
    }
    
    return self;
}

- (void) saveAction
{
    [super saveAction];
    [self updateList];
}

- (void) deleteAction
{
    [super deleteAction];
    [self updateList];
}

- (void) updateClient:(NSNotification *) notification
{
    NSNumber *modelFilterValue = [notification.userInfo objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE];
    
    if( modelFilterValue != (id)[NSNull null] )
    {
        [self.viewInstance setHidden:NO];
        
        self.modelFilterValue = modelFilterValue;
        ProductModel.modelFilterName = self.modelFilterName;
        ProductModel.modelFilterValue = self.modelFilterValue;
        self.modelItem = [ProductModel first];
        
        [self.viewInstance destroyForm];
        [self prepareEntity];
        [self.viewInstance createForm];
        
        [self updateList];
    }
    else
    {
        self.modelFilterValue = nil;
        [self.viewInstance setHidden:YES];
        [self updateList];
    }
}


- (void) updateList
{
    NSDictionary *updateMessage;
    if( self.modelFilterValue )
    {
        updateMessage = [NSDictionary dictionaryWithObject:self.modelFilterValue forKey:MLE_FIELDSET_MODEL_FILTERVALUE];
    }
    else
    {
        updateMessage = [NSDictionary dictionaryWithObject:[NSNull null] forKey:MLE_FIELDSET_MODEL_FILTERVALUE];
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PRODUCT_MANAGER_UPDATE_LIST
                                                        object:self
                                                      userInfo:updateMessage];
    
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
    
    NSDictionary *client = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                             @"client", MLE_FIELD_NAME_KEY,
                             @"Client", MLE_FIELD_LABEL_KEY,
                             @"ClientModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                             @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                             [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                             [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                             [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                             [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                             nil];
    
    [self.fieldData setObject:client forKey:@"client"];
}


@end
