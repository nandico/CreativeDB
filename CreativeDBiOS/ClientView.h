//
//  ClientView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/25/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientModel.h"

@protocol ClientDataSource <NSObject>

- (ClientModel *) selectedClient;

@end

@interface ClientView : UIView

@property (strong) id <ClientDataSource> dataSource;

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
- (void) updateData;


@end
