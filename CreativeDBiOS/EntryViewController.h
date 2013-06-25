//
//  EntryViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntryView.h"
#import "EntryModel.h"

@interface EntryViewController : UIViewController <EntryDataSource>

@property (strong) EntryModel *selectedEntry;
- (void) updateOrientation:( UIDeviceOrientation ) orientation;


@end
