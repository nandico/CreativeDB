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

@property (nonatomic, strong) EntryManagerView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@end

@implementation EntryManagerViewController

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
        
        self.view = self.viewInstance = [[EntryManagerView alloc] init];
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
    }
    
    return self;
}

- (void) deleteAction
{
    [super deleteAction];
    [self updateCredits];
}

- (void) newAction
{
    [super newAction];
    [self updateCredits];
}

- (void) nextAction
{
    [super nextAction];
    [self updateCredits];
}

- (void) previousAction
{
    [super previousAction];
    [self updateCredits];
}

- (void) updateCredits
{
    NSDictionary *entryMessage;
    if( self.modelItem )
    {
        entryMessage = [NSDictionary dictionaryWithObject:self.modelItem forKey:MLE_FIELDSET_MODEL_FILTERVALUE];
    }
    else
    {
        entryMessage = [NSDictionary dictionaryWithObject:[NSNull null] forKey:MLE_FIELDSET_MODEL_FILTERVALUE];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ENTRY_MANAGER_UPDATE_CREDITS
                                                        object:self
                                                      userInfo:entryMessage];
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
 
    NSDictionary *agency = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                             @"agency", MLE_FIELD_NAME_KEY,
                             @"Agency", MLE_FIELD_LABEL_KEY,
                             @"AgencyModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                             @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                             [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                             [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                             [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                             [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                             nil];
    
    [self.fieldData setObject:agency forKey:@"agency"];

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

    NSDictionary *product = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                             @"product", MLE_FIELD_NAME_KEY,
                             @"Product", MLE_FIELD_LABEL_KEY,
                             @"ProductModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                             @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                             [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                             [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                             [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                             [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                             nil];
    
    [self.fieldData setObject:product forKey:@"product"];
    
    NSDictionary *accessURL = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLETextFieldType], MLE_FIELD_TYPE_KEY,
                             @"accessURL", MLE_FIELD_NAME_KEY,
                             @"Access URL", MLE_FIELD_LABEL_KEY,
                             [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                             [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                             [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                             [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                             nil];
    
    [self.fieldData setObject:accessURL forKey:@"accessURL"];
    
    NSDictionary *caseURL = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLETextFieldType], MLE_FIELD_TYPE_KEY,
                             @"caseURL", MLE_FIELD_NAME_KEY,
                             @"Case URL", MLE_FIELD_LABEL_KEY,
                             [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                             [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                             [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                             [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                             nil];
    
    [self.fieldData setObject:caseURL forKey:@"caseURL"];
    
    NSDictionary *blurb = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLETextAreaFieldType], MLE_FIELD_TYPE_KEY,
                             @"blurb", MLE_FIELD_NAME_KEY,
                             @"Description", MLE_FIELD_LABEL_KEY,
                             [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                             [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                             [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                             [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                             nil];

    [self.fieldData setObject:blurb forKey:@"blurb"];
    
    NSMutableArray *years = [[NSMutableArray alloc] init];
    
    for( NSInteger i = 1970; i < [[self getActualYear] integerValue]; i ++ )
    {
        [years addObject:[NSString stringWithFormat:@"%ld", i ]];
    }
    
    NSDictionary *year = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLEStaticComboFieldType], MLE_FIELD_TYPE_KEY,
                             @"year", MLE_FIELD_NAME_KEY,
                             @"Year", MLE_FIELD_LABEL_KEY,
                             years, MLE_FIELD_STATIC_DOMAIN_KEY,
                             [NSNumber numberWithInteger:MLENumericDataType], MLE_FIELD_DATATYPE_KEY,
                             [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                             [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                             [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                             [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                             nil];
 
    [self.fieldData setObject:year forKey:@"year"];
}

- (NSNumber *) getActualYear
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    
    return [NSNumber numberWithInteger:[yearString integerValue]];
}



@end
