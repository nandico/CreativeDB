//
//  AgencyManagerView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AgencyManagerView.h"
#import "ManagerTextField.h"
#import "ManagerComboBox.h"
#import "ManagerLabel.h"

@interface  AgencyManagerView()

@property (nonatomic, strong) ManagerTextField *name;
@property (nonatomic, strong) ManagerComboBox *group;
@property (nonatomic, strong) ManagerLabel *testLabel;

@end

@implementation AgencyManagerView

- (id)init
{
    self = [super init];
    if (self)
    {
        [self name];
        [self group];
        [self testLabel];
    }
    return self;
}

- (ManagerTextField *)name
{
    if (!_name) {
        _name = [[ManagerTextField alloc] init];
        [self addSubview:_name];
    }
    
    return _name;
}

- (ManagerComboBox *)group
{
    if (!_group) {
        _group = [[ManagerComboBox alloc] init];
        [self addSubview:_group];
    }
    
    return _group;
}

- (ManagerLabel *)testLabel
{
    if (!_testLabel) {
        _testLabel = [[ManagerLabel alloc] init];
        [self addSubview:_testLabel];
    }
    
    return _testLabel;
}

@end
