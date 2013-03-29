//
//  ManagerEngine.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerEngine.h"

@interface ManagerEngine()

@property (nonatomic,strong) NSMutableArray *fieldContainers;

@end

@implementation ManagerEngine

- (id)init
{
    self = [super init];
    if (self) {
        _fieldContainers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) addFieldContainer:(ManagerFieldContainer *)fieldContainer
{
    [_fieldContainers addObject:fieldContainer];
}

- (void) arrangeContainers
{
    NSInteger containerCount = [_fieldContainers count];
    NSInteger totalHeight =  MLE_FIELDSET_OFFSET_Y + ( ( MLE_CONTAINER_HEIGHT + MLE_CONTAINER_SPACING ) * ( containerCount - 1 ) );
    
    ManagerFieldContainer *container;
    
    for( NSInteger itemIndex = 0; itemIndex < containerCount; itemIndex ++ )
    {
        container = [_fieldContainers objectAtIndex:itemIndex];
        
        container.frame = NSMakeRect(container.frame.origin.x,
                                     totalHeight - ( itemIndex * ( MLE_CONTAINER_HEIGHT + MLE_CONTAINER_SPACING ) ),
                                     container.frame.size.width,
                                     container.frame.size.height);
    }
}

@end