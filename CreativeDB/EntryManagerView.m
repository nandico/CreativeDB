//
//  EntryManagerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/30/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "EntryManagerView.h"
#import "ManagerEngine.h"

@interface  EntryManagerView()

@property (nonatomic, strong) ManagerEngine *engine;
@property (nonatomic, strong) ManagerFieldContainer *agency;
@property (nonatomic, strong) ManagerFieldContainer *client;
@property (nonatomic, strong) ManagerFieldContainer *country;
@property (nonatomic, strong) ManagerFieldContainer *product;
@property (nonatomic, strong) ManagerFieldContainer *accessURL;
@property (nonatomic, strong) ManagerFieldContainer *caseURL;
@property (nonatomic, strong) ManagerFieldContainer *blurb;
@property (nonatomic, strong) ManagerFieldContainer *name;
@property (nonatomic, strong) ManagerFieldContainer *year;

@end

@implementation EntryManagerView

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
    [_engine addFieldContainer:[self agency]];
    [_engine addFieldContainer:[self client]];
    [_engine addFieldContainer:[self country]];
    [_engine addFieldContainer:[self product]];
    [_engine addFieldContainer:[self accessURL]];
    [_engine addFieldContainer:[self caseURL]];
    [_engine addFieldContainer:[self blurb]];
    [_engine addFieldContainer:[self year]];
    
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

- (ManagerFieldContainer *)agency
{
    if(!_agency)
    {
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                                 @"agency", MLE_FIELD_NAME_KEY,
                                 @"Agency", MLE_FIELD_LABEL_KEY,
                                 @"AgencyModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                                 @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                                 [self.dataSource modelName], MLE_FIELDSET_MODEL_KEY,
                                 [self.dataSource modelItem], MLE_FIELDSET_MODEL_ITEM,
                                 nil];
        
        _agency = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_agency];
    }
    
    return _agency;
}

- (ManagerFieldContainer *)client
{
    if(!_client)
    {
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                                 @"client", MLE_FIELD_NAME_KEY,
                                 @"Client", MLE_FIELD_LABEL_KEY,
                                 @"ClientModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                                 @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                                 [self.dataSource modelName], MLE_FIELDSET_MODEL_KEY,
                                 [self.dataSource modelItem], MLE_FIELDSET_MODEL_ITEM,
                                 nil];
        
        _client = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_client];
    }
    
    return _client;
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

- (ManagerFieldContainer *)product
{
    if(!_product)
    {
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                                 @"product", MLE_FIELD_NAME_KEY,
                                 @"Product", MLE_FIELD_LABEL_KEY,
                                 @"ProductModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                                 @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                                 [self.dataSource modelName], MLE_FIELDSET_MODEL_KEY,
                                 [self.dataSource modelItem], MLE_FIELDSET_MODEL_ITEM,
                                 nil];
        
        _product = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_product];
    }
    
    return _product;
}

- (ManagerFieldContainer *)accessURL
{
    if(!_accessURL)
    {
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:MLETextFieldType], MLE_FIELD_TYPE_KEY,
                                 @"accessURL", MLE_FIELD_NAME_KEY,
                                 @"Access URL", MLE_FIELD_LABEL_KEY,
                                 [self.dataSource modelName], MLE_FIELDSET_MODEL_KEY,
                                 [self.dataSource modelItem], MLE_FIELDSET_MODEL_ITEM,
                                 nil];
        
        _accessURL = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_accessURL];
    }
    
    return _accessURL;
}

- (ManagerFieldContainer *)caseURL
{
    if(!_caseURL)
    {
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:MLETextFieldType], MLE_FIELD_TYPE_KEY,
                                 @"caseURL", MLE_FIELD_NAME_KEY,
                                 @"Case URL", MLE_FIELD_LABEL_KEY,
                                 [self.dataSource modelName], MLE_FIELDSET_MODEL_KEY,
                                 [self.dataSource modelItem], MLE_FIELDSET_MODEL_ITEM,
                                 nil];
        
        _caseURL = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_caseURL];
    }
    
    return _caseURL;
}

- (ManagerFieldContainer *)blurb
{
    if(!_blurb)
    {
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:MLETextAreaFieldType], MLE_FIELD_TYPE_KEY,
                                 @"blurb", MLE_FIELD_NAME_KEY,
                                 @"Case description", MLE_FIELD_LABEL_KEY,
                                 [self.dataSource modelName], MLE_FIELDSET_MODEL_KEY,
                                 [self.dataSource modelItem], MLE_FIELDSET_MODEL_ITEM,
                                 nil];
        
        _blurb = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_blurb];
    }
    
    return _blurb;
}

- (ManagerFieldContainer *)year
{
    if(!_year)
    {
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:MLEStaticComboFieldType], MLE_FIELD_TYPE_KEY,
                                 @"year", MLE_FIELD_NAME_KEY,
                                 @"Year", MLE_FIELD_LABEL_KEY,
                                 [NSNumber numberWithInteger:MLENumericDataType], MLE_FIELD_DATATYPE_KEY,
                                 [self.dataSource modelName], MLE_FIELDSET_MODEL_KEY,
                                 [self.dataSource modelItem], MLE_FIELDSET_MODEL_ITEM,
                                 nil];
        
        _year = [[ManagerFieldContainer alloc] initWithOptions:options];
        
        [self addSubview:_year];
    }
    
    return _year;
}



@end
