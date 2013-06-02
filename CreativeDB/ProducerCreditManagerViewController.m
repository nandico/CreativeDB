//
//  ProducerCreditViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/10/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ProducerCreditManagerViewController.h"
#import "EntryManagerViewController.h"
#import "ManagerEngine.h"
#import "ProducerCreditModel.h"
#import "ProducerCreditManagerView.h"

@interface ProducerCreditManagerViewController ()

@property (nonatomic, strong) ProducerCreditManagerView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@end

@implementation ProducerCreditManagerViewController

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
        
        
        self.view = self.viewInstance = [[ProducerCreditManagerView alloc] init];
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
                                                 selector:@selector(updateProducerCredits:)
                                                     name:ENTRY_MANAGER_UPDATE_CREDITS object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateView:)
                                                     name:PRODUCERCREDIT_MANAGER_UPDATE_VIEW object:nil];
    }
    
    return self;
}

- (void) updateView:(NSNotification *) notification
{
    ProducerCreditModel *item = [notification.userInfo objectForKey:MLE_FIELDSET_MODEL_ITEM];
    
    if( item )
    {
        self.modelItem = item.pk;
        [self.viewInstance destroyForm];
        [self prepareEntity];
        [self.viewInstance createForm];
    }
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PRODUCERCREDIT_MANAGER_UPDATE_LIST
                                                        object:self
                                                      userInfo:updateMessage];
    
}

- (void) updateProducerCredits:(NSNotification *) notification
{
    NSNumber *modelFilterValue = [notification.userInfo objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE];
    
    if( modelFilterValue != (id)[NSNull null] )
    {
        [self.viewInstance setHidden:NO];
        
        self.modelFilterValue = modelFilterValue;

        ProducerCreditModel.modelFilterValue = self.modelFilterValue;
        self.modelItem = [ProducerCreditModel first];
        
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

- (void) prepareEntity
{
    NSDictionary *entry = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                           @"entry", MLE_FIELD_NAME_KEY,
                           @"Entry", MLE_FIELD_LABEL_KEY,
                           @"EntryModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                           @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                           [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                           [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                           [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                           [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                           nil];
    
    [self.fieldData setObject:entry forKey:@"entry"];
    
    
    NSDictionary *producer = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                            @"producer", MLE_FIELD_NAME_KEY,
                            @"Producer", MLE_FIELD_LABEL_KEY,
                            @"ProducerModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                            @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                            [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                            [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                            [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                            [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                            nil];
    
    [self.fieldData setObject:producer forKey:@"producer"];
    
    NSDictionary *discipline = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                          @"discipline", MLE_FIELD_NAME_KEY,
                          @"Discipline", MLE_FIELD_LABEL_KEY,
                          @"DisciplineModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                          @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                          [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                          [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                          [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                          [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                          nil];
    
    [self.fieldData setObject:discipline forKey:@"discipline"];
    
    
}


@end
