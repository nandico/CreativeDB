//
//  EntryView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntryModel.h"

@protocol EntryDataSource <NSObject>

- (EntryModel *) selectedEntry;

@end

@interface EntryView : UIView

@property (strong) id <EntryDataSource> dataSource;

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
- (void) updateData;

@end
