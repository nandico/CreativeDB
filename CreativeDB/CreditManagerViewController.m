//
//  CreditManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 4/22/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CreditManagerViewController.h"
#import "EntryManagerViewController.h"
#import "CreditModel.h"
#import "ManagerEngine.h"

@interface CreditManagerViewController ()

@property (nonatomic, strong) CreditManagerView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@end

@implementation CreditManagerViewController

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
        
        self.view = self.viewInstance = [[CreditManagerView alloc] init];
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
                                                 selector:@selector(updateCredits:)
                                                     name:ENTRY_MANAGER_UPDATE_CREDITS object:nil];
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
        
    [[NSNotificationCenter defaultCenter] postNotificationName:CREDIT_MANAGER_UPDATE_LIST
                                                        object:self
                                                      userInfo:updateMessage];

}

- (void) updateCredits:(NSNotification *) notification
{
    NSNumber *modelFilterValue = [notification.userInfo objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE];
    
    if( modelFilterValue != (id)[NSNull null] )
    {
        [self.viewInstance setHidden:NO];
        
        self.modelFilterValue = modelFilterValue;
        CreditModel.modelFilterName = self.modelFilterName;
        CreditModel.modelFilterValue = self.modelFilterValue;
        self.modelItem = [CreditModel first];
        
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
   
    NSDictionary *person = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                            @"person", MLE_FIELD_NAME_KEY,
                            @"Person", MLE_FIELD_LABEL_KEY,
                            @"PersonModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                            @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                            [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                            [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                            [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                            [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                            nil];
    
    [self.fieldData setObject:person forKey:@"person"];

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
    
    NSDictionary *role = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                           @"role", MLE_FIELD_NAME_KEY,
                           @"Role", MLE_FIELD_LABEL_KEY,
                           @"RoleModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                           @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                           [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                           [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                           [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                           [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                           nil];
    
    [self.fieldData setObject:role forKey:@"role"];
    

}

@end
