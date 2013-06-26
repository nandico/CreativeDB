//
//  CountryViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/26/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryView.h"

@interface CountryViewController : UIViewController <CountryDataSource>

@property (strong) CountryModel *selectedCountry;
- (void) updateOrientation:( UIDeviceOrientation ) orientation;

@end
