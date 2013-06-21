//
//  AgencyView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/19/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgencyModel.h"

@protocol AgencyDataSource <NSObject>

- (AgencyModel *) selectedAgency;

@end


@interface AgencyView : UIView

@property (strong) id <AgencyDataSource> dataSource;

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
- (void) updateData;


@end
