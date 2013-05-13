//
//  ManagerTextFieldContainer.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerFieldContainer.h"
#import "ManagerEngine.h"
#import "FMDBDataAccess.h"

@interface ManagerFieldContainer()

@property (nonatomic,strong) NSDictionary *options;
@property (nonatomic,strong) NSString *nameSelector;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSString *modelFilterName;
@property (nonatomic, strong) NSNumber *modelFilterValue;
@property (nonatomic, strong) NSString *fieldName;
@property (nonatomic, strong) NSString *fieldLabel;
@property (nonatomic, strong) NSString *fieldLookupName;
@property (nonatomic, strong) NSString *fieldLookupModel;
@property (nonatomic,strong) NSNumber *fieldDataType;
@property (nonatomic, strong) NSMutableArray *staticDomainData;

@property (nonatomic, strong) ColumnModel *column;


@end

@implementation ManagerFieldContainer

- (id)initWithOptions:(NSDictionary *)options
{
    self = [super init];
    if (self) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [MLE_CONTAINER_COLOR CGColor];
        self.layer.cornerRadius = MLE_CONTAINER_CORNER_RADIUS;
        
        self.frame = NSMakeRect(0.0f, 0.0f, MLE_CONTAINER_WIDTH, MLE_CONTAINER_HEIGHT);
        
        _options = options;
        if( [self.options objectForKey:MLE_FIELD_TYPE_KEY] )
            _fieldType = [self.options objectForKey:MLE_FIELD_TYPE_KEY];
        
        if( [self.options objectForKey:MLE_FIELD_DATATYPE_KEY] )
            _fieldDataType = [self.options objectForKey:MLE_FIELD_DATATYPE_KEY];
        
        if( [self.options objectForKey:MLE_FIELD_NAME_KEY] )
            _fieldName = [self.options objectForKey:MLE_FIELD_NAME_KEY];
        
        if( [self.options objectForKey:MLE_FIELD_LABEL_KEY] )
            _fieldLabel = [self.options objectForKey:MLE_FIELD_LABEL_KEY];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_KEY] )
            _modelName = [self.options objectForKey:MLE_FIELDSET_MODEL_KEY];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM] )
            _modelItem = [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERNAME] )
            _modelFilterName = [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERNAME];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE] )
            _modelFilterName = [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE];
        
        if( [self.options objectForKey:MLE_FIELD_LOOKUP_NAME_KEY] )
            _fieldLookupName = [self.options objectForKey:MLE_FIELD_LOOKUP_NAME_KEY];
        
        if( [self.options objectForKey:MLE_FIELD_LOOKUP_MODEL_KEY ] )
            _fieldLookupModel = [self.options objectForKey:MLE_FIELD_LOOKUP_MODEL_KEY];
        
        if( [self.options objectForKey:MLE_FIELD_STATIC_DOMAIN_KEY ] )
            _staticDomainData = [self.options objectForKey:MLE_FIELD_STATIC_DOMAIN_KEY];
        
        if( _staticDomainData )
        {
            NSLog( @"STATIC DOMAIN DATA RECEIVED: %@", _staticDomainData );
        }
        else
        {
            if( [_fieldName isEqualToString:@"year"] )
            {
                NSLog( @"Container sem static data." );
            }
        }
        
        [self label];
        
        switch([_fieldType integerValue])
        {
            case MLETextFieldType:
                [self textField];
                break;
            case MLEComboFieldType:
                [self comboField];
                break;
            case MLEStaticComboFieldType:
                [self staticComboField];
                break;
            case MLETextAreaFieldType:
                [self textAreaField];
                break;
        }
        
        [self processColumnSchema];
        
    }

    return self;
}

- (void) processColumnSchema
{
    _column = [[FMDBDataAccess getInstance] getColumnSchema:[self tableName] withColumnName:_fieldName];
   
    _isNullable = self.column.notnull;
    _type = self.column.type;
    _isPk = self.column.pk;
    
}

- (NSString *) stringValue
{
    switch([_fieldType integerValue])
    {
        case MLETextFieldType:
            return [[self textField] stringValue];
        case MLEComboFieldType:
            return [[self comboField] stringValue];
        case MLEStaticComboFieldType:
            return [[self staticComboField] stringValue];
        case MLETextAreaFieldType:
            return [[self textAreaField] stringValue];
    }
    
    return nil;
}

- (NSString *) tableName
{
    SEL staticLoadSelector = NSSelectorFromString( @"tableName" );
    id baseModelClass = NSClassFromString( _modelName );
    
    return [baseModelClass performSelector:staticLoadSelector withObject:nil];
}

- (NSString *) bindForString
{
    SEL staticLoadSelector = NSSelectorFromString( @"loadModel:" );
    id baseModelClass = NSClassFromString( _modelName );
    id baseModel = [baseModelClass performSelector:staticLoadSelector withObject:_modelItem];
    
    return [baseModel valueForKey:_fieldName];
}

- (NSNumber *) bindForNumber
{
    SEL staticLoadSelector = NSSelectorFromString( @"loadModel:" );
    id baseModelClass = NSClassFromString( _modelName );
    id baseModel = [baseModelClass performSelector:staticLoadSelector withObject:_modelItem];
    SEL nameSelector = NSSelectorFromString( _fieldName );
    return [baseModel performSelector:nameSelector withObject:nil];
}


- (NSString *) bindLookupValue
{
    SEL staticLoadSelector = NSSelectorFromString( @"loadModel:" );
    id baseModelClass = NSClassFromString( _modelName );
    id baseModel = [baseModelClass performSelector:staticLoadSelector withObject:_modelItem];
    SEL nameSelector = NSSelectorFromString( _fieldName );
    id lookupModel = [baseModel performSelector:nameSelector withObject:nil];
    SEL lookupNameSelector = NSSelectorFromString( _fieldLookupName );
    
    return [lookupModel performSelector:lookupNameSelector withObject:nil];
}

- (NSMutableArray *) lookupData
{
    SEL staticLoadSelector = NSSelectorFromString( @"loadAll" );
    id lookupModel = NSClassFromString( _fieldLookupModel );
    
    return [lookupModel performSelector:staticLoadSelector withObject:nil];
}

- (ManagerLabel *) label
{
    if(!_label)
    {
        _label = [[ManagerLabel alloc] init];
        
        NSString *labelValue = [NSString stringWithFormat:@"%@:", _fieldLabel];
        [_label setStringValue:labelValue];
        
        [self addSubview:_label];
    }
         
    return _label;
}

- (ManagerTextField *) textField
{
    if(!_textField)
    {
        _textField = [[ManagerTextField alloc] init];
        [self addSubview:_textField];
        
        NSString *fieldValue = [self bindForString];
        if( fieldValue ) [_textField setStringValue:fieldValue];
    }
    
    return _textField;

}

- (ManagerTextAreaField *) textAreaField
{
    if(!_textAreaField)
    {
        _textAreaField = [[ManagerTextAreaField alloc] init];
        [self addSubview:_textAreaField];
        
        NSString *fieldValue = [self bindForString];
        if( fieldValue ) [_textAreaField setStringValue:fieldValue];
    }
    
    return _textAreaField;
    
}

- (void) bindCombo
{
    NSMutableArray *comboItems = [self lookupData];
    SEL lookupNameSelector = NSSelectorFromString( _fieldLookupName );    
    
    for( NSInteger comboIndex = 0; comboIndex < comboItems.count; comboIndex ++ )
    {
        id lookupModel = [comboItems objectAtIndex:comboIndex];
        [_comboField addItemWithObjectValue:[lookupModel performSelector:lookupNameSelector withObject:nil]];
    }
}

- (void) bindStaticCombo
{
    if( !_staticDomainData ) return;
    
    for( NSInteger comboIndex = 0; comboIndex < _staticDomainData.count; comboIndex ++ )
    {   
        [_comboField addItemWithObjectValue:[_staticDomainData objectAtIndex:comboIndex] ];
    }
}

- (ManagerComboBox *) comboField
{
    if(!_comboField)
    {
        _comboField = [[ManagerComboBox alloc] init];
        [self addSubview:_comboField];
        
        [self bindCombo];
        
        NSString *fieldValue = [self bindLookupValue];
        
        if( fieldValue ) [_comboField setStringValue:fieldValue];
 
    }
    
    return _comboField;
}

- (ManagerComboBox *) staticComboField
{
    if(!_comboField)
    {
        _comboField = [[ManagerComboBox alloc] init];
        [self addSubview:_comboField];
        
        [self bindStaticCombo];
        
        if( [_fieldDataType integerValue] == MLENumericDataType )
        {
            NSNumber *fieldValue = [self bindForNumber];
            if( fieldValue ) [_comboField setStringValue:[fieldValue stringValue]];
        }
        else
        {
            NSString *fieldValue = [self bindForString];
            if( fieldValue ) [_comboField setStringValue:fieldValue];
        }
    }
    
    return _comboField;
}


@end
