//
//  PersonDetailView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/2/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonDetailView.h"
#import "ManagerEngine.h"
#import "BaseManagerCompleteViewController.h"

@interface PersonDetailView ()

@end

@implementation PersonDetailView

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
    [self personName];
}

- (void) destroyForm
{
    [self.personName removeFromSuperview];
    
    _personName = nil;
}


- (ManagerHeader *) personName
{
    if(!_personName)
    {
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"Loading..", MLE_FIELDSET_MODEL_HEADERTITLE, nil ];
        
        _personName = [[ManagerHeader alloc] initWithOptions:options];
        _personName.frame = NSMakeRect(_personName.frame.origin.x,
                                       COMPLETE_VIEW_CONTAINER_HEADER_HEIGHT,
                                       _personName.frame.size.width,
                                       _personName.frame.size.height);
        
        [self addSubview:_personName];
    }
    
    return _personName;
}

@end
