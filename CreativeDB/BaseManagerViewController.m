//
//  BaseManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 4/14/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerViewController.h"
#import "ManagerFieldContainer.h"
#import "ManagerEngine.h"
#import "BaseManagerView.h"

@interface BaseManagerViewController ()

@property (nonatomic, strong) BaseManagerView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@end

@implementation BaseManagerViewController

- (void) saveAction
{
    id model;
    
    SEL staticLoadSelector = NSSelectorFromString( @"loadModel:" );
    SEL newSelector = NSSelectorFromString( @"new" );
    SEL saveSelector = NSSelectorFromString( @"save" );
    id baseModelClass = NSClassFromString( _modelName );
    
    if(_modelItem)
    {
        model = [baseModelClass performSelector:staticLoadSelector withObject:_modelItem];
    }
    else
    {
        //model = [[EntryModel alloc] init];
        model = [baseModelClass performSelector:newSelector withObject:nil];
    }

    NSString *key;
    NSString *fieldName;
    NSString *fieldType;
    NSString *fieldLookupModel;
    NSDictionary *options;
    ManagerFieldContainer *fieldContainer;
    NSString *stringValue;
    
    NSMutableString *requiredMessage = [NSMutableString new];
    
    // validating
    for( key in _fieldData )
    {
        options = [_fieldData objectForKey:key];
        fieldName = [options objectForKey:MLE_FIELD_NAME_KEY];
        fieldType = [options objectForKey:MLE_FIELD_TYPE_KEY];
        fieldLookupModel = [options objectForKey:MLE_FIELD_LOOKUP_MODEL_KEY];
        
        fieldContainer = [self.view valueForKey:fieldName];
        
        stringValue = [fieldContainer stringValue];
        
        if( [stringValue isEqualToString:@"" ] && [fieldContainer isNullable] )
        {
            [requiredMessage appendString:[NSString stringWithFormat:@"The %@ is required. \n", fieldName ]];
        }
    }
    
    if( [requiredMessage length] > 0 )
    {
        NSAlert *alert = [[NSAlert alloc] init];
        
        [alert setMessageText:requiredMessage];
        [alert runModal];
        
        return;
    }
    
    // saving
    for( key in _fieldData )
    {
        NSLog( @"key: %@", key );
        
        options = [_fieldData objectForKey:key];
        fieldName = [options objectForKey:MLE_FIELD_NAME_KEY];
        fieldType = [options objectForKey:MLE_FIELD_TYPE_KEY];
        fieldLookupModel = [options objectForKey:MLE_FIELD_LOOKUP_MODEL_KEY];
        
        fieldContainer = [self.view valueForKey:fieldName];
        
        stringValue = [fieldContainer stringValue];
        
        NSLog( @"fieldContainer: %@", stringValue );
        NSLog( @"String value: %@", stringValue );
        
        switch([fieldType integerValue])
        {
            case MLETextFieldType:
                [model setValue:stringValue forKey:fieldName];
                break;
            case MLEComboFieldType:
                if( YES )
                {
                    NSLog( @"model: %@", model );
                    NSLog( @"fieldName: %@", fieldName );

                    
                    SEL numericValueSelector = NSSelectorFromString( @"loadModelByStringValue:" );
                    id lookupModelClass = NSClassFromString( fieldLookupModel );
                    id lookupModel = [lookupModelClass performSelector:numericValueSelector withObject:stringValue];
                    
                    NSLog( @"Lookup model class: %@", lookupModelClass );
                    NSLog( @"Lookup model: %@", lookupModel );
                    
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
    
    [model performSelector:saveSelector];
    
    if( _modelItem )
    {
        
    }
    else
    {
        [self newAction];
    }
}

- (void) deleteAction
{
    id model;
    
    SEL deleteSelector = NSSelectorFromString( @"deleteModel" );
    
    if( self.modelItem )
    {
        SEL staticLoadSelector = NSSelectorFromString( @"loadModel:" );
        id baseModelClass = NSClassFromString( _modelName );

        model = [baseModelClass performSelector:staticLoadSelector withObject:_modelItem];
        
        [model performSelector:deleteSelector];
        
        [self previousAction];
    }
}

- (void) newAction
{
    self.modelItem = nil;
    
    [self.viewInstance destroyForm];
    [self prepareEntity];
    [self.viewInstance createForm];
}

- (void) previousAction
{
    id model;
    
    SEL previousSelector = NSSelectorFromString( @"previous" );
    SEL firstSelector = NSSelectorFromString( @"first" );
    SEL lastSelector = NSSelectorFromString( @"last" );
    id baseModelClass = NSClassFromString( _modelName );
    
    if( [baseModelClass respondsToSelector:NSSelectorFromString( @"modelFilterName" )] )
    {
        SEL modelFilterName = NSSelectorFromString( @"modelFilterName");
        SEL setModelFilterName = NSSelectorFromString( @"setModelFilterName:");

        SEL modelFilterValue = NSSelectorFromString( @"modelFilterValue");
        SEL setModelFilterValue = NSSelectorFromString( @"setModelFilterValue:");
        
        [baseModelClass performSelector:setModelFilterName withObject:self.modelFilterName];
        [baseModelClass performSelector:setModelFilterValue withObject:self.modelFilterValue];        
    }
        
    if( self.modelItem )
    {
        SEL staticLoadSelector = NSSelectorFromString( @"loadModel:" );
        id baseModelClass = NSClassFromString( _modelName );
        
        model = [baseModelClass performSelector:staticLoadSelector withObject:_modelItem];
        
        if( [model performSelector:previousSelector] )
        {
            self.modelItem = [model performSelector:previousSelector];
            [self.viewInstance destroyForm];
            [self prepareEntity];
            [self.viewInstance createForm];
        }
        else
        {
            self.modelItem = [baseModelClass performSelector:firstSelector];
            [self.viewInstance destroyForm];
            [self prepareEntity];
            [self.viewInstance createForm];
        }
    }
    else
    {
        self.modelItem = [baseModelClass performSelector:lastSelector];
        [self.viewInstance destroyForm];
        [self prepareEntity];
        [self.viewInstance createForm];
    }
}

- (void) nextAction
{
    id model;
    
    SEL nextSelector = NSSelectorFromString( @"next" );
    
    if( self.modelItem )
    {
        SEL staticLoadSelector = NSSelectorFromString( @"loadModel:" );
        id baseModelClass = NSClassFromString( _modelName );
        
        model = [baseModelClass performSelector:staticLoadSelector withObject:_modelItem];
        
        if( [model performSelector:nextSelector] )
        {
            self.modelItem = [model performSelector:nextSelector];
            [self.viewInstance destroyForm];
            [self prepareEntity];
            [self.viewInstance createForm];
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

- (void) prepareEntity
{
    
}

@end
