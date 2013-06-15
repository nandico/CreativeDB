//
//  PersonThumb.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/15/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonThumbLabel.h"
#import "ClientEngine.h"

@interface PersonThumb : UIView <ClientLayoutable>

@property (nonatomic, strong) PersonThumbLabel *initials;

@property (assign) CGFloat offsetX;
@property (assign) CGFloat offsetY;
@property (assign) CGFloat prefferedWidth;
@property (assign) CGFloat prefferedHeight;

- (NSString *) extractInitials:(NSString *) name;

@end
