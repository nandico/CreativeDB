//
//  AgencyManagerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AgencyManagerView.h"
#import "ManagerEngine.h"
#import "ManagerActionBar.h"

@interface  AgencyManagerView()

@property (nonatomic, strong) ManagerEngine *engine;
@property (nonatomic, strong) ManagerFieldContainer *name;
@property (nonatomic, strong) ManagerFieldContainer *group;
@property (nonatomic, strong) ManagerFieldContainer *country;
@property (nonatomic, strong) ManagerActionBar *actionBar;

@end

@implementation AgencyManagerView

- (id)init
{
    self = [super init];
    if (self)
    {
        _engine = [[ManagerEngine alloc] init];
    }
    return self;
}

- (void) createForm
{
    [_engine addFieldContainer:[self name]];
    [_engine addFieldContainer:[self group]];
    [_engine addFieldContainer:[self country]];
    
    
    [_engine arrangeContainers];
}

- (ManagerFieldContainer *)name
{
    if(!_name)
    {
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:MLETextFieldType], MLE_FIELD_TYPE_KEY,
                                 @"name", MLE_FIELD_NAME_KEY,
                                 @"Name", MLE_FIELD_LABEL_KEY,
                                 [self.dataSource modelName], MLE_FIELDSET_MODEL_KEY,
                                 [self.dataSource modelItem], MLE_FIELDSET_MODEL_ITEM,
                                 nil];
        
        _name = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_name];
    }
    
    return _name;
}


- (ManagerFieldContainer *)group
{
    if(!_group)
    {
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                                 @"group", MLE_FIELD_NAME_KEY,
                                 @"Group", MLE_FIELD_LABEL_KEY,
                                 @"GroupModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                                 @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                                 [self.dataSource modelName], MLE_FIELDSET_MODEL_KEY,
                                 [self.dataSource modelItem], MLE_FIELDSET_MODEL_ITEM,
                                 nil];
        
        _group = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_group];
    }
    
    return _group;
}

- (ManagerFieldContainer *)country
{
    if(!_country)
    {
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                                 @"country", MLE_FIELD_NAME_KEY,
                                 @"Country", MLE_FIELD_LABEL_KEY,
                                 @"CountryModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                                 @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                                 [self.dataSource modelName], MLE_FIELDSET_MODEL_KEY,
                                 [self.dataSource modelItem], MLE_FIELDSET_MODEL_ITEM,
                                 nil];
        
        _country = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_country];
    }
    
    return _country;
}




@end
