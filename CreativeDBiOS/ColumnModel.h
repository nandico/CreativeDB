//
//  ColumnModel.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/14/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColumnModel : NSObject

@property (strong) NSNumber *width;
@property (strong) NSNumber *height;
@property (strong) NSNumber *percentWidth;
@property (strong) NSNumber *percentHeight;

- (id) initWithPercent:(NSNumber *) percent;
- (id) initWithFixed:(NSNumber *) fixed;

@end
