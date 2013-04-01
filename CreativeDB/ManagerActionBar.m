//
//  ManagerActionBar.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/31/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerActionBar.h"
#import "ManagerButton.h"
#import "ManagerEngine.h"

@interface ManagerActionBar()

@property (nonatomic,strong) ManagerButton *save;

@end

@implementation ManagerActionBar

- (id)initWithOptions:(NSDictionary *)options
{
    self = [super init];
    if (self)
    {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [[NSColor MLE_CONTAINER_COLOR] CGColor];
        self.layer.cornerRadius = MLE_CONTAINER_CORNER_RADIUS;
        
        self.frame = NSMakeRect(0.0f, 0.0f, MLE_CONTAINER_WIDTH, MLE_CONTAINER_HEIGHT);
        
        [self save];
    }
    return self;
}

- (NSButton *) save
{
    if(!_save)
    {
        _save = [[ManagerButton alloc] init];
        _save.title = @"Save";
        
        [_save setTarget:self];
        [_save setAction:@selector(saveAction)];
        
        [self addSubview:_save];
    }
    
    return _save;
}

- (IBAction) saveAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MLE_NOTIFICATION_SAVE
                                                        object:self
                                                      userInfo:nil];
}


@end
