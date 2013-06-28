//
//  ProducerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProducerView.h"

@interface ProducerViewController : UIViewController <ProducerDataSource>

@property (strong) ProducerModel *selectedProducer;
- (void) updateOrientation:( UIDeviceOrientation ) orientation;

@end
