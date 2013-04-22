//
//  CreditManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 4/22/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "CreditManagerViewController.h"
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
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_KEY] ) self.modelName = [self.options objectForKey:MLE_FIELDSET_MODEL_KEY];
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM] ) self.modelItem = [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM];
        
        self.view = self.viewInstance = [[CreditManagerView alloc] init];
        self.viewInstance.dataSource = self;
        
        self.fieldData = [[NSMutableDictionary alloc] init];
        
        [self prepareEntity];
        
        [self.viewInstance createForm];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(saveAction)
                                                     name:MLE_NOTIFICATION_SAVE object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deleteAction)
                                                     name:MLE_NOTIFICATION_DELETE object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(newAction)
                                                     name:MLE_NOTIFICATION_NEW object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(nextAction)
                                                     name:MLE_NOTIFICATION_NEXT object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(previousAction)
                                                     name:MLE_NOTIFICATION_PREVIOUS object:nil];
    }
    
    return self;
}

- (void) prepareEntity
{
   
    NSDictionary *person = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                            @"person", MLE_FIELD_NAME_KEY,
                            @"Person", MLE_FIELD_LABEL_KEY,
                            @"PersonModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                            @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                            self.modelName, MLE_FIELDSET_MODEL_KEY,
                            self.modelItem, MLE_FIELDSET_MODEL_ITEM,
                            nil];
    
    [self.fieldData setObject:person forKey:@"person"];

    NSDictionary *entry = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                            @"entry", MLE_FIELD_NAME_KEY,
                            @"Entry", MLE_FIELD_LABEL_KEY,
                            @"EntryModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                            @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                            self.modelName, MLE_FIELDSET_MODEL_KEY,
                            self.modelItem, MLE_FIELDSET_MODEL_ITEM,
                            nil];
    
    [self.fieldData setObject:entry forKey:@"entry"];
    
    NSDictionary *role = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                           @"role", MLE_FIELD_NAME_KEY,
                           @"Role", MLE_FIELD_LABEL_KEY,
                           @"RoleModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                           @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                           self.modelName, MLE_FIELDSET_MODEL_KEY,
                           self.modelItem, MLE_FIELDSET_MODEL_ITEM,
                           nil];
    
    [self.fieldData setObject:role forKey:@"role"];
    

}

@end
