//
//  PersonViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/12/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonViewController.h"
#import "ClientEngine.h"

@interface PersonViewController ()

@property (strong, nonatomic) PersonView *viewInstance;

@property (nonatomic) UIDeviceOrientation currentOrientation;

@end

@implementation PersonViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[PersonView alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateData:)
                                                     name:NOTIFICATION_WAKE_PERSON_DETAIL object:nil];
    }
    return self;
}

- (void) updateData:(NSNotification *) notification
{
    self.selectedScoreEntry = [notification.userInfo objectForKey:PERSON_ITEM];
    
    if( self.selectedScoreEntry )
    {
    }
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    [self.viewInstance updateOrientation:orientation];
    _currentOrientation = orientation;
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
