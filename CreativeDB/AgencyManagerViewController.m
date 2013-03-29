//
//  AgencyManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AgencyManagerViewController.h"
#import "AgencyManagerView.h"

@interface AgencyManagerViewController ()

@property (nonatomic, strong) AgencyManagerView *agencyView;

@end

@implementation AgencyManagerViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.agencyView = [[AgencyManagerView alloc] init];
    }
    
    return self;
}

@end
