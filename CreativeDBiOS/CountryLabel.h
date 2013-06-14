//
//  CountryLabel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/11/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLabel.h"
#import "ClientEngine.h"

@interface CountryLabel : BaseLabel <ClientLayoutable>

@property (assign) CGFloat offsetX;
@property (assign) CGFloat offsetY;
@property (assign) CGFloat prefferedWidth;
@property (assign) CGFloat prefferedHeight;


@end
