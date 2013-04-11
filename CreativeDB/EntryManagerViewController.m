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
        
        _fieldData = [[NSMutableDictionary alloc] init];
        
        [self prepareEntity];
        
        [self.entryView createForm];

        
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
    
    NSLog( @"Form for %@", _modelItem );

    NSDictionary *name = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLETextFieldType], MLE_FIELD_TYPE_KEY,
                             @"name", MLE_FIELD_NAME_KEY,
                             @"Name", MLE_FIELD_LABEL_KEY,
                             _modelName, MLE_FIELDSET_MODEL_KEY,
                             _modelItem, MLE_FIELDSET_MODEL_ITEM,
                             nil];
    
    [_fieldData setObject:name forKey:@"name"];
 
    NSDictionary *agency = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                             @"agency", MLE_FIELD_NAME_KEY,
                             @"Agency", MLE_FIELD_LABEL_KEY,
                             @"AgencyModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                             @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                             _modelName, MLE_FIELDSET_MODEL_KEY,
                             _modelItem, MLE_FIELDSET_MODEL_ITEM,
                             nil];
    
    [_fieldData setObject:agency forKey:@"agency"];

    NSDictionary *client = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                             @"client", MLE_FIELD_NAME_KEY,
                             @"Client", MLE_FIELD_LABEL_KEY,
                             @"ClientModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                             @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                             _modelName, MLE_FIELDSET_MODEL_KEY,
                             _modelItem, MLE_FIELDSET_MODEL_ITEM,
                             nil];
    
    [_fieldData setObject:client forKey:@"client"];
    
    NSDictionary *country = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                             @"country", MLE_FIELD_NAME_KEY,
                             @"Country", MLE_FIELD_LABEL_KEY,
                             @"CountryModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                             @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                             _modelName, MLE_FIELDSET_MODEL_KEY,
                             _modelItem, MLE_FIELDSET_MODEL_ITEM,
                             nil];
    
    [_fieldData setObject:country forKey:@"country"];

    NSDictionary *product = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                             @"product", MLE_FIELD_NAME_KEY,
                             @"Product", MLE_FIELD_LABEL_KEY,
                             @"ProductModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                             @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                             _modelName, MLE_FIELDSET_MODEL_KEY,
                             _modelItem, MLE_FIELDSET_MODEL_ITEM,
                             nil];
    
    [_fieldData setObject:product forKey:@"product"];
    
    NSDictionary *accessURL = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLETextFieldType], MLE_FIELD_TYPE_KEY,
                             @"accessURL", MLE_FIELD_NAME_KEY,
                             @"Access URL", MLE_FIELD_LABEL_KEY,
                             _modelName, MLE_FIELDSET_MODEL_KEY,
                             _modelItem, MLE_FIELDSET_MODEL_ITEM,
                             nil];
    
    [_fieldData setObject:accessURL forKey:@"accessURL"];
    
    NSDictionary *caseURL = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLETextFieldType], MLE_FIELD_TYPE_KEY,
                             @"caseURL", MLE_FIELD_NAME_KEY,
                             @"Case URL", MLE_FIELD_LABEL_KEY,
                             _modelName, MLE_FIELDSET_MODEL_KEY,
                             _modelItem, MLE_FIELDSET_MODEL_ITEM,
                             nil];
    
    [_fieldData setObject:caseURL forKey:@"caseURL"];
    
    NSDictionary *blurb = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLETextAreaFieldType], MLE_FIELD_TYPE_KEY,
                             @"blurb", MLE_FIELD_NAME_KEY,
                             @"Case description", MLE_FIELD_LABEL_KEY,
                             _modelName, MLE_FIELDSET_MODEL_KEY,
                             _modelItem, MLE_FIELDSET_MODEL_ITEM,
                             nil];
    
    [_fieldData setObject:blurb forKey:@"blurb"];
    
    NSMutableArray *years = [[NSMutableArray alloc] init];
    
    for( NSInteger i = 1970; i < [[self getActualYear] integerValue]; i ++ )
    {
        [years addObject:[NSString stringWithFormat:@"%ld", i ]];
    }
    
    NSDictionary *year = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLEStaticComboFieldType], MLE_FIELD_TYPE_KEY,
                             @"year", MLE_FIELD_NAME_KEY,
                             @"Year", MLE_FIELD_LABEL_KEY,
                             [NSNumber numberWithInteger:MLENumericDataType], MLE_FIELD_DATATYPE_KEY,
                             _modelName, MLE_FIELDSET_MODEL_KEY,
                             _modelItem, MLE_FIELDSET_MODEL_ITEM,
                             years, MLE_FIELD_STATIC_DOMAIN_KEY,
                             nil];

    [_fieldData setObject:year forKey:@"year"];
    
}

- (NSNumber *) getActualYear
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    
    return [NSNumber numberWithInteger:[yearString integerValue]];
}

- (void) saveAction
{
    EntryModel *model;
    
    if(_modelItem)
    {
        model = [EntryModel loadModel:_modelItem];
    }
    else
    {
        model = [[EntryModel alloc] init];
    }
        
    for( NSString *key in _fieldData )
    {
        NSDictionary *options = [_fieldData objectForKey:key];
        NSString *fieldName = [options objectForKey:MLE_FIELD_NAME_KEY];
        NSNumber *fieldType = [options objectForKey:MLE_FIELD_TYPE_KEY];
        NSString *fieldLookupModel = [options objectForKey:MLE_FIELD_LOOKUP_MODEL_KEY];
        
        ManagerFieldContainer *fieldContainer = [self.entryView valueForKey:fieldName];
        
        NSString *stringValue = [fieldContainer stringValue];
     
        switch([fieldType integerValue])
        {
            case MLETextFieldType:
                [model setValue:stringValue forKey:fieldName];
                break;
            case MLEComboFieldType:
                if( YES )
                {
                    SEL numericValueSelector = NSSelectorFromString( @"loadModelByStringValue:" );
                    id lookupModelClass = NSClassFromString( fieldLookupModel );
                    id lookupModel = [lookupModelClass performSelector:numericValueSelector withObject:stringValue];
                    [model setValue:lookupModel forKey:fieldName];
                }
                break;
            case MLEStaticComboFieldType:
                [model setValue:stringValue forKey:fieldName];
                break;
            case MLETextAreaFieldType:
                [model setValue:stringValue forKey:fieldName];
                break;
        }
    }
    
    [model save];
}

- (void) deleteAction
{
    if( _modelItem )
    {
        EntryModel *model = [EntryModel loadModel:_modelItem];
        [model deleteModel];
        
        [self previousAction];
    }
}

- (void) newAction
{
    self.modelItem = nil;
    
    [self.entryView destroyForm];
    [self prepareEntity];
    [self.entryView createForm];
}

- (void) previousAction
{
    if( _modelItem )
    {
        EntryModel *model = [EntryModel loadModel:_modelItem];
        
        if( model.previous )
        {
            self.modelItem = model.previous;
            [self.entryView destroyForm];
            [self prepareEntity];
            [self.entryView createForm];
        }
        else
        {
            self.modelItem = [EntryModel first];
            [self.entryView destroyForm];
            [self prepareEntity];
            [self.entryView createForm];
        }
    }
    else
    {
        self.modelItem = [EntryModel last];
        [self.entryView destroyForm];
        [self prepareEntity];
        [self.entryView createForm];
    }
}

- (void) nextAction
{
    if( _modelItem )
    {
        EntryModel *model = [EntryModel loadModel:_modelItem];
        
        if( model.next )
        {
            self.modelItem = model.next;
            [self.entryView destroyForm];
            [self prepareEntity];
            [self.entryView createForm];
        }
        else
        {
            [self newAction];
        }
    }
    else
    {
        [self newAction];
    }
}

@end
