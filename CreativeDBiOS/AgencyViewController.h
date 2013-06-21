//
//  AgencyViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/19/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgencyView.h"

@interface AgencyViewController : UIViewController <AgencyDataSource>

@property (strong) AgencyModel *selectedAgency;
- (void) updateOrientation:( UIDeviceOrientation ) orientation;

@end
