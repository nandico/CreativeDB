//
//  ManagerHeader.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/27/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerHeader.h"
#import "ManagerEngine.h"

@implementation ManagerHeader

- (id)initWithOptions:(NSDictionary *) options
{
    self = [super init];
    if (self) {
        
        self.frame = NSMakeRect( MLE_HEADER_OFFSET_X, MLE_HEADER_OFFSET_Y, MLE_HEADER_WIDTH, MLE_HEADER_HEIGHT );
        [self setFont:MLE_HEADER_FONT];
        [self setTextColor:MLE_HEADER_COLOR];
        [self setEditable:NO];
        [self setBezeled:NO];
        
        if( [options objectForKey:MLE_FIELDSET_MODEL_HEADERTITLE] )
        {
            NSString *headerTitle = [options objectForKey:MLE_FIELDSET_MODEL_HEADERTITLE];
            [self setStringValue:headerTitle ];
        }
            
        
    }
    
    return self;
}

@end
