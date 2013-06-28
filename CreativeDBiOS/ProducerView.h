//
//  ProducerView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProducerModel.h"

@protocol ProducerDataSource <NSObject>

- (ProducerModel *) selectedProducer;

@end


@interface ProducerView : UIView

@property (strong) id <ProducerDataSource> dataSource;

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
- (void) updateData;


@end
