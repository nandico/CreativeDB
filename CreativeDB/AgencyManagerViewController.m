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

@property (nonatomic, strong) AgencyManagerView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@end

@implementation AgencyManagerViewController

- (id)initWithOptions:(NSDictionary *)options;
{
    self = [super init];
    if (self) {
        _options = options;
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_KEY] ) self.modelItem = [self.options objectForKey:MLE_FIELDSET_MODEL_KEY];
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM] ) self.modelItem = [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM];

        self.view = self.viewInstance = [[AgencyManagerView alloc] init];
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
    NSDictionary *name = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInteger:MLETextFieldType], MLE_FIELD_TYPE_KEY,
                          @"name", MLE_FIELD_NAME_KEY,
                          @"Name", MLE_FIELD_LABEL_KEY,
                          self.modelName, MLE_FIELDSET_MODEL_KEY,
                          self.modelItem, MLE_FIELDSET_MODEL_ITEM,
                          nil];
    
    [self.fieldData setObject:name forKey:@"name"];
    
    
    NSDictionary *group = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                           @"group", MLE_FIELD_NAME_KEY,
                           @"Group", MLE_FIELD_LABEL_KEY,
                           @"GroupModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                           @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                           self.modelName, MLE_FIELDSET_MODEL_KEY,
                           self.modelItem, MLE_FIELDSET_MODEL_ITEM,
                           nil];
    
    [self.fieldData setObject:group forKey:@"group"];
    
    NSDictionary *country = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                             @"country", MLE_FIELD_NAME_KEY,
                             @"Country", MLE_FIELD_LABEL_KEY,
                             @"CountryModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                             @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                             self.modelName, MLE_FIELDSET_MODEL_KEY,
                             self.modelItem, MLE_FIELDSET_MODEL_ITEM,
                             nil];
    
    [self.fieldData setObject:country forKey:@"country"];
}

@end
