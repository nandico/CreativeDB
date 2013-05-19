//
//  MenuManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/19/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "MenuManagerViewController.h"
#import "MenuManagerView.h"
#import "ManagerMenuButton.h"

@interface MenuManagerViewController ()

@property (nonatomic, strong) MenuManagerView *viewInstance;
@property (nonatomic, strong) ManagerMenuButton *entries;
@property (nonatomic, strong) ManagerMenuButton *agencies;

@end

@implementation MenuManagerViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[MenuManagerView alloc] init];
        [self prepareMenu];
    }
    
    return self;
}

- (void) prepareMenu
{
    [self entries];
    [self agencies];
}

- (ManagerMenuButton *) entries
{
    if(!_entries)
    {
        _entries = [[ManagerMenuButton alloc] init];
        [self.viewInstance addSubview:_entries];
    }
    
    return _entries;
}

- (ManagerMenuButton *) agencies
{
    if(!_agencies)
    {
        _agencies = [[ManagerMenuButton alloc] init];
        [self.viewInstance addSubview:_agencies];
    }
    
    return _agencies;
}


@end
