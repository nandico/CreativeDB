//
//  AgencyManagerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AgencyManagerView.h"
#import "ManagerComboBox.h"
#import "ManagerEngine.h"

@interface  AgencyManagerView()

@property (nonatomic, strong) ManagerEngine *engine;
@property (nonatomic, strong) ManagerFieldContainer *name;
@property (nonatomic, strong) ManagerFieldContainer *group;
@property (nonatomic, strong) ManagerFieldContainer *country;

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

- (AgencyModel *)baseModel
{
    return [self.dataSource baseModel];
}

- (ManagerFieldContainer *)name
{
    if(!_name)
    {
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:MLETextFieldType], MLE_FIELD_TYPE_KEY,
                                 @"name", MLE_FIELD_NAME_KEY,
                                 @"Name", MLE_FIELD_LABEL_KEY,
                                 [[self.dataSource baseModel] name], MLE_FIELD_VALUE_KEY,
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
                                 @"name", MLE_FIELD_NAME_SELECTOR,
                                 [[self.dataSource baseModel] group], MLE_FIELD_MODEL_KEY,
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
                                 [[self.dataSource baseModel] country], MLE_FIELD_MODEL_KEY,
                                 nil];
        
        _country = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_country];
    }
    
    return _country;
}




@end
