//
//  AwardManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/12/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AwardManagerViewController.h"
#import "EntryManagerViewController.h"
#import "AwardModel.h"

@interface AwardManagerViewController ()

@property (nonatomic, strong) AwardManagerView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@end

@implementation AwardManagerViewController

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
        
        self.view = self.viewInstance = [[AwardManagerView alloc] init];
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
                                                 selector:@selector(updateAward:)
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AWARD_MANAGER_UPDATE_LIST
                                                        object:self
                                                      userInfo:updateMessage];
    
}

- (void) updateAward:(NSNotification *) notification
{
    NSNumber *modelFilterValue = [notification.userInfo objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE];
    
    if( modelFilterValue != (id)[NSNull null] )
    {
        [self.viewInstance setHidden:NO];
        
        self.modelFilterValue = modelFilterValue;
        AwardModel.modelFilterName = self.modelFilterName;
        AwardModel.modelFilterValue = self.modelFilterValue;
        self.modelItem = [AwardModel first];
        
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

    NSDictionary *metal = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                           @"metal", MLE_FIELD_NAME_KEY,
                           @"Metal", MLE_FIELD_LABEL_KEY,
                           @"MetalModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                           @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                           [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                           [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                           [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                           [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                           nil];
    
    [self.fieldData setObject:metal forKey:@"metal"];
    
    NSDictionary *festival = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                           @"festival", MLE_FIELD_NAME_KEY,
                           @"Festival", MLE_FIELD_LABEL_KEY,
                           @"FestivalModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                           @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                           [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                           [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                           [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                           [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                           nil];
    
    [self.fieldData setObject:festival forKey:@"festival"];
    
    NSDictionary *category = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                           @"category", MLE_FIELD_NAME_KEY,
                           @"Category", MLE_FIELD_LABEL_KEY,
                           @"CategoryModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                           @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                           [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                           [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                           [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                           [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                           nil];
    
    [self.fieldData setObject:category forKey:@"category"];
    
    NSDictionary *subcategory = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                           @"subcategory", MLE_FIELD_NAME_KEY,
                           @"Subcategory", MLE_FIELD_LABEL_KEY,
                           @"SubcategoryModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                           @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                           [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                           [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                           [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                           [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                           nil];
    
    [self.fieldData setObject:subcategory forKey:@"subcategory"];
    
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
                          self.modelName, MLE_FIELDSET_MODEL_KEY,
                          self.modelItem, MLE_FIELDSET_MODEL_ITEM,
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
