//
//  BaseManagerListViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 4/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BaseManagerListViewController : NSViewController

- (id) packNSNull:(id) value;
- (id) unpackNSNull:(id) value;

@end
