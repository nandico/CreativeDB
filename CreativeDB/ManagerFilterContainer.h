//
//  ManagerFilterContainer.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/4/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ManagerFilterComboBox.h"
#import "ManagerFilterTextField.h"

#define MLE_NOTIFICATION_FILTER_COMBO_UPDATE @"MLE_NOTIFICATION_FILTER_COMBO_UPDATE"
#define MLE_FILTER_COMBO_ITEM @"MLE_FILTER_COMBO_ITEM"
#define MLE_FILTER_COMBO_CONTAINER @"MLE_FILTER_COMBO_CONTAINER"

@interface ManagerFilterContainer : NSView

@property (nonatomic, strong) NSString *modelTitle;

@property (nonatomic,strong) NSNumber *fieldType;
@property (nonatomic, strong) ManagerFilterTextField *textField;
@property (nonatomic, strong) ManagerFilterComboBox *comboField;

@property (nonatomic, assign) BOOL isNullable;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) BOOL isPk;

- (id)initWithOptions:(NSDictionary *)options;
- (NSString *) stringValue;

@end
