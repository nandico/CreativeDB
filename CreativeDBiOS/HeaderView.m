//
//  HeaderView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "HeaderView.h"
#import "HeaderLabel.h"
#import "ClientEngine.h"
#import "PersonIdView.h"
#import "ClientEngine.h"
#import "BaseScrollView.h"
#import "MarkerView.h"

@interface HeaderView()

@property (strong, nonatomic) HeaderLabel *title;
@property (strong, nonatomic) PersonIdView *logo;

@property (strong, nonatomic) BaseScrollView *menuScroll;

@property (strong, nonatomic) BaseButton *dashboardButton;
@property (strong, nonatomic) BaseButton *calendarButton;
@property (strong, nonatomic) BaseButton *peopleButton;
@property (strong, nonatomic) BaseButton *agenciesButton;
@property (strong, nonatomic) BaseButton *entriesButton;
@property (strong, nonatomic) BaseButton *clientsButton;
@property (strong, nonatomic) BaseButton *countriesButton;
@property (strong, nonatomic) BaseButton *groupsButton;
@property (strong, nonatomic) BaseButton *producersButton;


@property (nonatomic) UIDeviceOrientation currentOrientation;

@end

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:HEADER_BACKGROUND_COLOR];
        [self title];
        [self logo];
        [self menuScroll];

        [self dashboardButton];
        [self peopleButton];
        [self agenciesButton];
        [self entriesButton];
        [self clientsButton];
        [self countriesButton];
        [self groupsButton];
        [self producersButton];
        
        [self grid];

    }
    return self;
}

- (void) grid
{
   for( NSInteger gridCounter = 0; gridCounter < 10; gridCounter ++ )
    {
        MarkerView *marker = [[MarkerView alloc] initWithFrame:CGRectMake(( gridCounter * 125.0f ) - 6.0f, 118.0f, 50.0f, 50.0f)];
        [self.menuScroll addSubview:marker];
    }
    
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation
{
    _currentOrientation = orientation;
    
    [self layoutSubviews];
}

- (BaseScrollView *) menuScroll
{
    if( !_menuScroll )
    {
        _menuScroll = [[BaseScrollView alloc] init];
        [self addSubview:_menuScroll];
    }
    
    return _menuScroll;
}

- (HeaderLabel *) title
{
    if(!_title)
    {
        _title = [[HeaderLabel alloc] init];
        [_title setText:APP_NAME];
        [self addSubview:_title];
    }
    
    return _title;
}

- (PersonIdView *) logo
{
    if(!_logo)
    {
        _logo = [[PersonIdView alloc] init];
        [self addSubview:_logo];
    }
    
    return _logo;
}

- (BaseButton *) dashboardButton
{
    if( !_dashboardButton )
    {
        _dashboardButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        [_dashboardButton setTitle:@"Dashboard" forState:UIControlStateNormal];
        _dashboardButton.titleLabel.font = MENU_BUTTON_FONT;
        _dashboardButton.titleLabel.textColor = MENU_BUTTON_FONT_COLOR;
        [_dashboardButton addTarget:self action:@selector(dashboardButtonAction) forControlEvents:UIControlEventTouchDown];
        _dashboardButton.frame = CGRectMake(125.0f * 0, 0, 125.0f, 125.0f);
        
        [self.menuScroll addSubview:_dashboardButton];
    }
    
    return _dashboardButton;
}

- (BaseButton *) calendarButton
{
    if( !_calendarButton )
    {
        _calendarButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        [_calendarButton setTitle:@"Calendar" forState:UIControlStateNormal];
        _calendarButton.titleLabel.font = MENU_BUTTON_FONT;
        _calendarButton.titleLabel.textColor = MENU_BUTTON_FONT_COLOR;
        [_calendarButton addTarget:self action:@selector(calendarButtonAction) forControlEvents:UIControlEventTouchDown];
        _calendarButton.frame = CGRectMake(125.0f * 1.0f, 0, 125.0f, 125.0f);
        
        [self.menuScroll addSubview:_calendarButton];
    }
    
    return _dashboardButton;
}

- (BaseButton *) peopleButton
{
    if( !_peopleButton )
    {
        _peopleButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        [_peopleButton setTitle:@"People" forState:UIControlStateNormal];
        _peopleButton.titleLabel.font = MENU_BUTTON_FONT;
        _peopleButton.titleLabel.textColor = MENU_BUTTON_FONT_COLOR;
        [_peopleButton addTarget:self action:@selector(peopleButtonAction) forControlEvents:UIControlEventTouchDown];
        _peopleButton.frame = CGRectMake(125.0f * 1.0f, 0, 125.0f, 125.0f);

        [self.menuScroll addSubview:_peopleButton];
    }
    
    return _peopleButton;
}

- (BaseButton *) agenciesButton
{
    if( !_agenciesButton )
    {
        _agenciesButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        [_agenciesButton setTitle:@"Agencies" forState:UIControlStateNormal];
        _agenciesButton.titleLabel.font = MENU_BUTTON_FONT;
        _agenciesButton.titleLabel.textColor = MENU_BUTTON_FONT_COLOR;
        [_agenciesButton addTarget:self action:@selector(agenciesButtonAction) forControlEvents:UIControlEventTouchDown];
        _agenciesButton.frame = CGRectMake(125.0f * 2.0f, 0, 125.0f, 125.0f);
        
        [self.menuScroll addSubview:_agenciesButton];
    }
    
    return _agenciesButton;
}

- (BaseButton *) entriesButton
{
    if( !_entriesButton )
    {
        _entriesButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        [_entriesButton setTitle:@"Entries" forState:UIControlStateNormal];
        _entriesButton.titleLabel.font = MENU_BUTTON_FONT;
        _entriesButton.titleLabel.textColor = MENU_BUTTON_FONT_COLOR;
        [_entriesButton addTarget:self action:@selector(entriesButtonAction) forControlEvents:UIControlEventTouchDown];
        _entriesButton.frame = CGRectMake(125.0f * 3.0f, 0, 125.0f, 125.0f);
        
        [self.menuScroll addSubview:_entriesButton];
    }
    
    return _entriesButton;
}


- (BaseButton *) clientsButton
{
    if( !_clientsButton )
    {
        _clientsButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        [_clientsButton setTitle:@"Clients" forState:UIControlStateNormal];
        _clientsButton.titleLabel.font = MENU_BUTTON_FONT;
        _clientsButton.titleLabel.textColor = MENU_BUTTON_FONT_COLOR;
        [_clientsButton addTarget:self action:@selector(clientsButtonAction) forControlEvents:UIControlEventTouchDown];
        _clientsButton.frame = CGRectMake(125.0f * 4.0f, 0, 125.0f, 125.0f);


        [self.menuScroll addSubview:_clientsButton];
    }
    
    return _clientsButton;
}

- (BaseButton *) countriesButton
{
    if( !_countriesButton )
    {
        _countriesButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        [_countriesButton setTitle:@"Countries" forState:UIControlStateNormal];
        _countriesButton.titleLabel.font = MENU_BUTTON_FONT;
        _countriesButton.titleLabel.textColor = MENU_BUTTON_FONT_COLOR;
        [_countriesButton addTarget:self action:@selector(countriesButtonAction) forControlEvents:UIControlEventTouchDown];
        _countriesButton.frame = CGRectMake(125.0f * 5.0f, 0, 125.0f, 125.0f);

        
        [self.menuScroll addSubview:_countriesButton];
    }
    
    return _countriesButton;
}

- (BaseButton *) groupsButton
{
    if( !_groupsButton )
    {
        _groupsButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        [_groupsButton setTitle:@"Groups" forState:UIControlStateNormal];
        _groupsButton.titleLabel.font = MENU_BUTTON_FONT;
        _groupsButton.titleLabel.textColor = MENU_BUTTON_FONT_COLOR;
        [_groupsButton addTarget:self action:@selector(groupsButtonAction) forControlEvents:UIControlEventTouchDown];
        _groupsButton.frame = CGRectMake(125.0f * 6.0f, 0, 125.0f, 125.0f);

        
        [self.menuScroll addSubview:_groupsButton];
    }
    
    return _groupsButton;
}

- (BaseButton *) producersButton
{
    if( !_producersButton )
    {
        _producersButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        [_producersButton setTitle:@"Producers" forState:UIControlStateNormal];
        _producersButton.titleLabel.font = MENU_BUTTON_FONT;
        _producersButton.titleLabel.textColor = MENU_BUTTON_FONT_COLOR;
        [_producersButton addTarget:self action:@selector(producersButtonAction) forControlEvents:UIControlEventTouchDown];
        _producersButton.frame = CGRectMake(125.0f * 7.0f, 0, 125.0f, 125.0f);

        
        [self.menuScroll addSubview:_producersButton];
    }
    
    return _producersButton;
}

- (void) layoutSubviews
{
    ClientEngine *engine = [[ClientEngine alloc] init];
    
    [engine startEngine];
    [engine setMustConsiderHeader:NO];
    [engine setCurrentOrientation:self.currentOrientation ];

    ColumnModel *columnLogo = [[ColumnModel alloc] initWithFixed:@125];
    ColumnModel *columnTitle = [[ColumnModel alloc] initWithFixed:@250];
    ColumnModel *columnMenu = [[ColumnModel alloc] initWithPercent:@100];
  
    LineModel *line1 = [[LineModel alloc] initWithOptions:[NSMutableArray arrayWithObjects:columnLogo, columnTitle,
                                                           columnMenu, nil]];

    
    line1.height = @125;
    [engine addLine:line1];    
    
    _title.offsetX = APP_LEFT_PADDING;
    [engine applyFrame:_title withLine:line1 andColumn:columnTitle];
    
    [engine applyFrame:_logo withLine:line1 andColumn:columnLogo];

    [engine applyFrame:_menuScroll withLine:line1 andColumn:columnMenu];
    _menuScroll.backgroundColor = PALLETE_WHITE_FOR_BACKGROUND;
    
    _logo.backgroundColor = PALLETE_BASE_COLOR_B;
    _logo.userInitials.textColor = PALLETE_WHITE_FOR_ELEMENTS;
    _logo.userInitials.text = @"CD";

    _dashboardButton.backgroundColor = PALLETE_BASE_COLOR_G;
    _calendarButton.backgroundColor = PALLETE_BASE_COLOR_I;
    _peopleButton.backgroundColor = PALLETE_BASE_COLOR_D;
    _agenciesButton.backgroundColor = PALLETE_BASE_COLOR_E;
    _entriesButton.backgroundColor = PALLETE_BASE_COLOR_A;
    _clientsButton.backgroundColor = PALLETE_BASE_COLOR_H;
    _countriesButton.backgroundColor = PALLETE_BASE_COLOR_J;
    _groupsButton.backgroundColor = PALLETE_BASE_COLOR_F;
    _producersButton.backgroundColor = PALLETE_BASE_COLOR_C;

    _menuScroll.contentSize = CGSizeMake(125.0 * 8, 125.0);
}

- (void) dashboardButtonAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_DASHBOARD
                                                        object:self
                                                      userInfo:nil];
}

- (void) calendarButtonAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_CALENDAR
                                                        object:self
                                                      userInfo:nil];
}

- (void) peopleButtonAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_PERSON_SCORE
                                                        object:self
                                                      userInfo:nil];
}

- (void) agenciesButtonAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_AGENCIES_SCORE
                                                        object:self
                                                      userInfo:nil];
}

- (void) clientsButtonAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_CLIENTS_SCORE
                                                        object:self
                                                      userInfo:nil];
}

- (void) entriesButtonAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_ENTRIES_SCORE
                                                        object:self
                                                      userInfo:nil];
}


- (void) countriesButtonAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_COUNTRIES_SCORE
                                                        object:self
                                                      userInfo:nil];
}

- (void) groupsButtonAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_GROUPS_SCORE
                                                        object:self
                                                      userInfo:nil];
}

- (void) producersButtonAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_PRODUCERS_SCORE
                                                        object:self
                                                      userInfo:nil];
}


@end
