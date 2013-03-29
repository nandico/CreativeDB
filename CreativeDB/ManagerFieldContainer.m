//
//  ManagerTextFieldContainer.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerFieldContainer.h"
#import "ManagerEngine.h"

@interface ManagerFieldContainer()

@property (nonatomic,strong) NSDictionary *options;
@property (nonatomic,strong) NSNumber *fieldType;
@property (nonatomic,strong) NSString *stringValue;
@property (nonatomic,strong) BaseModel *baseModel;
@property (nonatomic,strong) NSString *nameSelector;

@end

@implementation ManagerFieldContainer

- (id)initWithOptions:(NSDictionary *)options
{
    self = [super init];
    if (self) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [[NSColor MLE_CONTAINER_COLOR] CGColor];
        self.layer.cornerRadius = MLE_CONTAINER_CORNER_RADIUS;
        
        self.frame = NSMakeRect(0.0f, 0.0f, MLE_CONTAINER_WIDTH, MLE_CONTAINER_HEIGHT);
        
        _options = options;
        _fieldType = [self.options objectForKey:MLE_FIELD_TYPE_KEY];
        
        if( [self.options objectForKey:MLE_FIELD_VALUE_KEY] ) _stringValue = [self.options objectForKey:MLE_FIELD_VALUE_KEY];
        if( [self.options objectForKey:MLE_FIELD_MODEL_KEY] ) _baseModel = [self.options objectForKey:MLE_FIELD_MODEL_KEY];
        if( [self.options objectForKey:MLE_FIELD_NAME_SELECTOR] ) _nameSelector = [self.options objectForKey:MLE_FIELD_NAME_SELECTOR];
                
        [self label];
        
        switch([_fieldType integerValue])
        {
            case MLETextFieldType:
                [self textField];
                break;
            case MLEComboFieldType:
                [self comboField];
                break;
        }
    }
    
    return self;
}

- (ManagerLabel *) label
{
    if(!_label)
    {
        _label = [[ManagerLabel alloc] init];
        
        NSString *labelValue = [NSString stringWithFormat:@"%@:", [self.options objectForKey:MLE_FIELD_LABEL_KEY]];
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
        
        if( _stringValue ) [self setStringValue:_stringValue];
    }
    
    return _textField;
}

- (ManagerComboBox *) comboField
{
    if(!_comboField)
    {
        _comboField = [[ManagerComboBox alloc] init];
        [self addSubview:_comboField];
        
        NSLog( @"base model de dentro: %@", _baseModel );
        
        if( _baseModel )
        {
            NSLog( @"processando. %@", _nameSelector );
            
            SEL realSelector = NSSelectorFromString(_nameSelector);
            NSLog( @"Result: %@", [_baseModel performSelector:realSelector] );
        }
    }
    
    return _comboField;
}


@end
