//
//  HeaderViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "HeaderViewController.h"
#import "HeaderView.h"

@interface HeaderViewController ()

@property (nonatomic, strong) HeaderView *viewInstance;

@end

@implementation HeaderViewController

- (id) init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, 1024.0f, 768.0f)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
