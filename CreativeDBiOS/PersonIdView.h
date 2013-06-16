//
//  PersonIdView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/15/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseLabel.h"
#import "ClientEngine.h"
#import "PersonThumbLabel.h"

@interface PersonIdView : BaseLabel <ClientLayoutable>

@property (nonatomic, strong) PersonThumbLabel *userInitials;

@property (assign) CGFloat offsetX;
@property (assign) CGFloat offsetY;
@property (assign) CGFloat prefferedWidth;
@property (assign) CGFloat prefferedHeight;

- (NSString *) extractInitials:(NSString *) name;


@end
