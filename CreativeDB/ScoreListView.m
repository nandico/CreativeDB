//
//  ScoreListView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/4/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ScoreListView.h"
#import "ManagerFilterContainer.h"

@interface  ScoreListView()

@property (nonatomic, strong) ManagerFilterContainer *country;
@property (nonatomic, strong) ManagerFilterContainer *group;
@property (nonatomic, strong) NSMutableArray *filters;

@end

@implementation ScoreListView

- (id)init
{
    self = [super init];
    if (self)
    {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [MLE_BACKGROUND_COLOR CGColor];
    }
    return self;
}

- (void) createForm
{
    _filters = [[NSMutableArray alloc] init];
    
    [_filters addObject:[self country]];
    [_filters addObject:[self group]];
    
    [self arrangeFilters];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateFilter:)
                                                 name:MLE_NOTIFICATION_FILTER_COMBO_UPDATE object:self.country];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateFilter:)
                                                 name:MLE_NOTIFICATION_FILTER_COMBO_UPDATE object:self.group];
    
}

- (void) arrangeFilters
{
    for( NSInteger i = 0; i < _filters.count; i ++ )
    {
        ManagerFilterContainer *filter = [_filters objectAtIndex:i];
        
        filter.frame = NSMakeRect( filter.frame.origin.x,
                                  MLE_FILTER_CONTAINER_OFFSET_Y - ( MLE_FILTER_CONTAINER_HEIGHT * i ) ,
                                  filter.frame.size.width,
                                  filter.frame.size.height);
    }
}

- (void) destroyForm
{
    [self.country removeFromSuperview];
    [self.group removeFromSuperview];
    
    _country = nil;
    _group = nil;
}

- (ManagerFilterContainer *)country
{
    if(!_country)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"country"];
        
        _country = [[ManagerFilterContainer alloc] initWithOptions:options];
        
        [self addSubview:_country];
    }
    
    return _country;
}

- (ManagerFilterContainer *)group
{
    if(!_group)
    {
        NSDictionary *options = [[self.dataSource fieldData] objectForKey:@"group"];
        
        _group = [[ManagerFilterContainer alloc] initWithOptions:options];
        
        [self addSubview:_group];
    }
    
    return _group;
}

- (void) updateFilter:(NSNotification *) notification
{
    ManagerFilterContainer *container = notification.object;
    ManagerFilterComboBox *combo = [notification.userInfo objectForKey:MLE_FILTER_COMBO_ITEM];
    
    NSDictionary *updateMessage = [NSDictionary dictionaryWithObjectsAndKeys:combo, MLE_FILTER_COMBO_ITEM,
                                   container, MLE_FILTER_COMBO_CONTAINER, nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MLE_NOTIFICATION_FILTER_COMBO_UPDATE
                                                        object:self
                                                      userInfo:updateMessage];
}


@end
