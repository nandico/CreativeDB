//
//  ClientViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientView.h"

@interface ClientViewController : UIViewController <ClientDataSource>

@property (strong) ClientModel *selectedClient;
- (void) updateOrientation:( UIDeviceOrientation ) orientation;


@end
