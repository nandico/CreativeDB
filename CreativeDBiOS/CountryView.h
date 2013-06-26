//
//  CountryView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/26/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryModel.h"

@protocol CountryDataSource <NSObject>

- (CountryModel *) selectedCountry;

@end

@interface CountryView : UIView

@property (strong) id <CountryDataSource> dataSource;

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
- (void) updateData;

@end
