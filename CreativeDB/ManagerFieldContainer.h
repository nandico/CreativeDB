//
//  ManagerTextFieldContainer.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ManagerTextField.h"
#import "ManagerTextAreaField.h"
#import "ManagerComboBox.h"
#import "ManagerLabel.h"
#import "BaseModel.h"

@interface ManagerFieldContainer : NSView

+ (NSString *)teste;

@property (nonatomic, strong) ManagerLabel *label;
@property (nonatomic,strong) NSNumber *fieldType;
@property (nonatomic, strong) ManagerTextField *textField;
@property (nonatomic, strong) ManagerTextAreaField *textAreaField;
@property (nonatomic, strong) ManagerComboBox *comboField;

@property (nonatomic, strong) NSString *banana;

@property (nonatomic, assign) BOOL isNullable;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) BOOL isPk;


- (void)applyFilterWithName:(NSString *)filterName andValue:(NSString *)filterValue;
- (id)initWithOptions:(NSDictionary *)options;
- (NSString *) stringValue;

@end
