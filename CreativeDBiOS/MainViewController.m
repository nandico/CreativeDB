//
//  MainViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "HeaderViewController.h"

@interface MainViewController()

@property (strong, nonatomic) MainView *viewInstance;
@property (strong, nonatomic) HeaderViewController *header;

@end

@implementation MainViewController

- (id) init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[MainView alloc] init];
        self.header = [[HeaderViewController alloc] init];
        [self.viewInstance addSubview:self.header.view];
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
