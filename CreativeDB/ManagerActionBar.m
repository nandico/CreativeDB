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

@property (nonatomic,strong) ManagerButton *previous;
@property (nonatomic,strong) ManagerButton *new;
@property (nonatomic,strong) ManagerButton *save;
@property (nonatomic,strong) ManagerButton *next;

@property (nonatomic,strong) NSMutableArray *buttons;

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
        
        _buttons = [[NSMutableArray alloc] init];
        
        [_buttons addObject:[self previous]];
        [_buttons addObject:[self new]];
        [_buttons addObject:[self save]];
        [_buttons addObject:[self next]];
        
        [self arrangeButtons];
    }
    return self;
}

- (void) arrangeButtons
{
    for( NSInteger i = 0; i < _buttons.count; i ++ )
    {
        ManagerButton *button = [_buttons objectAtIndex:i];
        
        button.frame = NSMakeRect( MLE_BUTTON_OFFSET_X + ( button.frame.size.width * i ),
                                  button.frame.origin.y,
                                  button.frame.size.width,
                                  button.frame.size.height);
    }
}

- (ManagerButton *) new
{
    if(!_new)
    {
        _new = [[ManagerButton alloc] init];
        _new.title = @"New";
        
        [_new setTarget:self];
        [_new setAction:@selector(newAction)];
        
        [self addSubview:_new];
    }
    
    return _new;
}

- (IBAction) newAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MLE_NOTIFICATION_NEW
                                                        object:self
                                                      userInfo:nil];
}


- (ManagerButton *) save
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

- (ManagerButton *) previous
{
    if(!_previous)
    {
        _previous = [[ManagerButton alloc] init];
        _previous.title = @"<<";
        
        [_previous setTarget:self];
        [_previous setAction:@selector(previousAction)];
        
        [self addSubview:_previous];
    }
    
    return _previous;
}

- (IBAction) previousAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MLE_NOTIFICATION_PREVIOUS
                                                        object:self
                                                      userInfo:nil];
}

- (ManagerButton *) next
{
    if(!_next)
    {
        _next = [[ManagerButton alloc] init];
        _next.title = @">>";
        
        [_next setTarget:self];
        [_next setAction:@selector(nextAction)];
        
        [self addSubview:_next];
    }
    
    return _next;
}

- (IBAction) nextAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MLE_NOTIFICATION_NEXT
                                                        object:self
                                                      userInfo:nil];
}


@end
