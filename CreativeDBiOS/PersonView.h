//
//  PersonView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/12/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreModel.h"

@protocol PersonDataSource <NSObject>

- (PersonModel *) selectedPerson;

@end

@interface PersonView : UIView

@property (assign) id <PersonDataSource> dataSource;

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
- (void) updateData;

@end
