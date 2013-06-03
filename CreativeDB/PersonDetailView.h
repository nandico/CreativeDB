//
//  PersonDetailView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/2/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ManagerHeader.h"

@interface PersonDetailView : NSView

@property (nonatomic, strong) ManagerHeader *personName;

- (void) createForm;
- (void) destroyForm;

@end
