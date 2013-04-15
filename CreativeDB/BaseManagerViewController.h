//
//  BaseManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 4/14/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BaseManagerViewController : NSViewController

@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

@end
