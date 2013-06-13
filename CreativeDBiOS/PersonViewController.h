//
//  PersonViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/12/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonView.h"

@interface PersonViewController : UIViewController <PersonDataSource>

@property (nonatomic, strong) PersonModel *selectedPerson;
- (void) updateOrientation:( UIDeviceOrientation ) orientation;

@end
