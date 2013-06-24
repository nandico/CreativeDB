//
//  DashboardSquare.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/24/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseView.h"
#import "ClientEngine.h"
#import "H1Label.h"
#import "H2Label.h"

@interface DashboardSquare : UIView <ClientLayoutable>

@property (assign) CGFloat offsetX;
@property (assign) CGFloat offsetY;
@property (assign) CGFloat prefferedWidth;
@property (assign) CGFloat prefferedHeight;

@property (strong, nonatomic) BaseView *background;
@property (strong, nonatomic) H1Label *title;
@property (strong, nonatomic) H2Label *content;

- (void) updateOrientation:( UIDeviceOrientation ) orientation;

@end
