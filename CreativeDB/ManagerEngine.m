//
//  ManagerEngine.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerEngine.h"
#import "ManagerHeader.h"

@interface ManagerEngine()

@property (nonatomic, strong) NSMutableArray *fieldContainers;
@property (nonatomic, strong) ManagerHeader *header;
@property (nonatomic, strong) ManagerActionBar *actionBar;


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

- (void) addActionBar:(ManagerActionBar *) actionBar;
{
    _actionBar = actionBar;
}

- (void) addHeader:(ManagerHeader *) header;
{
    _header = header;
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
    
    NSInteger originalX;
    
    ManagerFieldContainer *container;    
    
    NSInteger itemIndex;
    
    for( itemIndex = 0; itemIndex < containerCount; itemIndex ++ )
    {
        container = [_fieldContainers objectAtIndex:itemIndex];
        totalHeight += [self containerHeight:container withSpacing:YES];
        [container setAlphaValue:0.0f];
        
        originalX = container.frame.origin.x;
    }
    
    _header.frame = NSMakeRect(_header.frame.origin.x,
                               totalHeight - actualHeight, _header.frame.size.width, _header.frame.size.height);
    
    for( itemIndex = 0; itemIndex < containerCount; itemIndex ++ )
    {
        container = [_fieldContainers objectAtIndex:itemIndex];
        
        actualHeight += [self containerHeight:container withSpacing:YES];
        
        container.frame = NSMakeRect(originalX - 10.0f,
                                                  totalHeight - actualHeight,
                                                  container.frame.size.width,
                                                  [self containerHeight:container withSpacing:NO]);
        
        NSMutableDictionary *containerDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                    container, @"container",
                                                    [NSNumber numberWithInteger:originalX], @"originalX",
                                                    nil];
        
        float timerCalc = (float) itemIndex;
        timerCalc = timerCalc / 50;
        
        [NSTimer scheduledTimerWithTimeInterval:timerCalc
                                         target:self
                                       selector:@selector(animateContainer:)
                                       userInfo:containerDictionary
                                        repeats:NO];
    }
}

- (void) removeContainers
{
    _fieldContainers = [[NSMutableArray alloc] init];
}

- (void) animateContainer:(NSTimer *) timer
{
    NSDictionary *containerDictionary = [timer userInfo];
    
    ManagerFieldContainer *container = [containerDictionary objectForKey:@"container"];
    NSNumber *originalX = [containerDictionary objectForKey:@"originalX"];
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * context){
        [context setDuration:0.1f ];
        
        [[container animator] setFrame:NSMakeRect([originalX floatValue],
                                                  container.frame.origin.y,
                                                  container.frame.size.width,
                                                  container.frame.size.height)];
        
        [[container animator] setAlphaValue:1.0f];
    } completionHandler:^{
    }];
}


@end