//
//  ManagerTextFieldContainer.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ManagerTextField.h"
#import "ManagerComboBox.h"
#import "ManagerLabel.h"
#import "BaseModel.h"

@interface ManagerFieldContainer : NSView

@property (nonatomic, strong) ManagerLabel *label;
@property (nonatomic, strong) ManagerTextField *textField;
@property (nonatomic, strong) ManagerComboBox *comboField;

- (id)initWithOptions:(NSDictionary *)options;

@end
