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

- (NSInteger) containerHeight:(ManagerFieldContainer *)fieldContainer withSpacing:(BOOL) spacing
{
    NSInteger height;
    
    if( [fieldContainer.fieldType integerValue] == MLETextAreaFieldType )
    {
        height = MLE_TEXTAREA_CONTAINER_HEIGHT;
    }
    else
    {
        height = MLE_CONTAINER_HEIGHT;
    }
    
    if( spacing )
    {
        return height + MLE_CONTAINER_SPACING;
    }
    else
    {
        return height;
    }
}

- (void) arrangeContainers
{
    NSInteger containerCount = [_fieldContainers count];
    NSInteger totalHeight = MLE_FIELDSET_OFFSET_Y;
    NSInteger actualHeight = 0;
    
    ManagerFieldContainer *container;    
    
    NSInteger itemIndex;
    
    for( itemIndex = 0; itemIndex < containerCount; itemIndex ++ )
    {
        container = [_fieldContainers objectAtIndex:itemIndex];
        totalHeight += [self containerHeight:container withSpacing:YES];
    }
    
    for( itemIndex = 0; itemIndex < containerCount; itemIndex ++ )
    {
        container = [_fieldContainers objectAtIndex:itemIndex];
        
        actualHeight += [self containerHeight:container withSpacing:YES];
        
        container.frame = NSMakeRect(container.frame.origin.x,
                                     totalHeight - actualHeight,
                                     container.frame.size.width,
                                     [self containerHeight:container withSpacing:NO]);
    }
}

@end