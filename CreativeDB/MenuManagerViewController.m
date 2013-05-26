//
//  MenuManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/19/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "MenuManagerViewController.h"
#import "BaseLayeredView.h"
#import "ManagerMenuButton.h"
#import "ManagerEngine.h"

@interface MenuManagerViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;
@property (nonatomic, strong) ManagerMenuButton *entries;
@property (nonatomic, strong) ManagerMenuButton *agencies;
@property (nonatomic, strong) ManagerMenuButton *clients;
@property (nonatomic, strong) ManagerMenuButton *persons;
@property (nonatomic, strong) ManagerMenuButton *roles;

@property (nonatomic,strong) NSMutableArray *buttons;

@end

@implementation MenuManagerViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[BaseLayeredView alloc] init];
        [self prepareMenu];
    }
    
    return self;
}

- (void) prepareMenu
{
    _buttons = [[NSMutableArray alloc] init];
    
    [_buttons addObject:[self entries]];
    [_buttons addObject:[self agencies]];
    [_buttons addObject:[self clients]];
    [_buttons addObject:[self persons]];
    [_buttons addObject:[self roles]];
    
    [self arrangeButtons];
}

- (void) arrangeButtons
{
    for( NSInteger i = 0; i < _buttons.count; i ++ )
    {
        ManagerMenuButton *button = [_buttons objectAtIndex:i];
        
        button.frame = NSMakeRect( MLE_MENU_BUTTON_OFFSET_X + ( button.frame.size.width * i ),
                                  button.frame.origin.y,
                                  button.frame.size.width,
                                  button.frame.size.height);
    }
}

- (ManagerMenuButton *) entries
{
    if(!_entries)
    {
        _entries = [[ManagerMenuButton alloc] init];
        _entries.title = @"Entries";
        [_entries setTarget:self];
        [_entries setAction:@selector(entriesAction)];
        [self.viewInstance addSubview:_entries];
    }
    
    return _entries;
}

- (ManagerMenuButton *) agencies
{
    if(!_agencies)
    {
        _agencies = [[ManagerMenuButton alloc] init];
        _agencies.title = @"Agencies";
        [_agencies setTarget:self];
        [_agencies setAction:@selector(agenciesAction)];
        [self.viewInstance addSubview:_agencies];
    }
    
    return _agencies;
}

- (ManagerMenuButton *) clients
{
    if(!_clients)
    {
        _clients = [[ManagerMenuButton alloc] init];
        _clients.title = @"Clients";
        [_clients setTarget:self];
        [_clients setAction:@selector(clientsAction)];
        [self.viewInstance addSubview:_clients];
    }
    
    return _clients;
}

- (ManagerMenuButton *) persons
{
    if(!_persons)
    {
        _persons = [[ManagerMenuButton alloc] init];
        _persons.title = @"Persons";
        [_persons setTarget:self];
        [_persons setAction:@selector(personsAction)];
        [self.viewInstance addSubview:_persons];
    }
    
    return _persons;
}

- (ManagerMenuButton *) roles
{
    if(!_roles)
    {
        _roles = [[ManagerMenuButton alloc] init];
        _roles.title = @"Roles";
        [_roles setTarget:self];
        [_roles setAction:@selector(rolesAction)];
        [self.viewInstance addSubview:_roles];
    }
    
    return _roles;
}

- (void) entriesAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_ENTRIES
                                                        object:self
                                                      userInfo:nil];
}

- (void) agenciesAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_AGENCIES
                                                        object:self
                                                      userInfo:nil];
}

- (void) clientsAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_CLIENTS
                                                        object:self
                                                      userInfo:nil];
}

- (void) personsAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_PERSONS
                                                        object:self
                                                      userInfo:nil];
}

- (void) rolesAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_ROLES
                                                        object:self
                                                      userInfo:nil];
}


@end
