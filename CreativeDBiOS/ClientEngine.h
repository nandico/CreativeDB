//
//  ClientEngine.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LineModel.h"
#import "ColumnModel.h"
#import "BaseLabel.h"

#define APP_NAME @"CreativeDB"
#define APP_LEFT_PADDING 35.0f

#define NOTIFICATION_WAKE_DASHBOARD @"NOTIFICATION_WAKE_DASHBOARD"
#define NOTIFICATION_WAKE_CALENDAR @"NOTIFICATION_WAKE_CALENDAR"
#define NOTIFICATION_WAKE_PERSON_DETAIL @"NOTIFICATION_WAKE_PERSON_DETAIL"
#define NOTIFICATION_WAKE_PERSON_SCORE @"NOTIFICATION_WAKE_PERSON_SCORE"
#define NOTIFICATION_WAKE_AGENCIES_DETAIL @"NOTIFICATION_WAKE_AGENCIES_DETAIL"
#define NOTIFICATION_WAKE_AGENCIES_SCORE @"NOTIFICATION_WAKE_AGENCIES_SCORE"
#define NOTIFICATION_WAKE_ENTRIES_DETAIL @"NOTIFICATION_WAKE_ENTRIES_DETAIL"
#define NOTIFICATION_WAKE_ENTRIES_SCORE @"NOTIFICATION_WAKE_ENTRIES_SCORE"
#define NOTIFICATION_WAKE_CLIENTS_DETAIL @"NOTIFICATION_WAKE_CLIENTS_DETAIL"
#define NOTIFICATION_WAKE_CLIENTS_SCORE @"NOTIFICATION_WAKE_CLIENTS_SCORE"
#define NOTIFICATION_WAKE_COUNTRIES_DETAIL @"NOTIFICATION_WAKE_COUNTRIES_DETAIL"
#define NOTIFICATION_WAKE_COUNTRIES_SCORE @"NOTIFICATION_WAKE_COUNTRIES_SCORE"
#define NOTIFICATION_WAKE_GROUPS_DETAIL @"NOTIFICATION_WAKE_GROUPS_DETAIL"
#define NOTIFICATION_WAKE_GROUPS_SCORE @"NOTIFICATION_WAKE_GROUPS_SCORE"
#define NOTIFICATION_WAKE_PRODUCERS_DETAIL @"NOTIFICATION_WAKE_PRODUCERS_DETAIL"
#define NOTIFICATION_WAKE_PRODUCERS_SCORE @"NOTIFICATION_WAKE_PRODUCERS_SCORE"

#define NOTIFICATION_ITEM @"NOTIFICATION_ITEM"

#define SCREEN_LANDSCAPE_FRAME CGRectMake(0, 0, 1024.0f, 724.0f)
#define SCREEN_PORTRAIT_FRAME CGRectMake(0, 0, 768.0f, 980.0f)

#define CONTENT_LANDSCAPE_FRAME CGRectMake(0, 125.0f, 1024.0f, 643.0f)
#define CONTENT_PORTRAIT_FRAME CGRectMake(0, 125.0f, 768.0f, 855.0f)

#define INNER_CONTENT_LANDSCAPE_FRAME CGRectMake(0, 0, 1024.0f, 643.0f)
#define INNER_CONTENT_PORTRAIT_FRAME CGRectMake(0, 0, 768.0f, 855.0f)

#define DASHBOARD_CONTENT_LANDSCAPE_FRAME CGRectMake(0, 0, 1024.0f, 623.0f)
#define DASHBOARD_CONTENT_PORTRAIT_FRAME CGRectMake(0, 0, 768.0f, 879.0f)


#define HEADER_TITLE_COLOR [UIColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:1.0f]
#define HEADER_TITLE_BACKGROUND_COLOR nil
#define HEADER_TITLE_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:60.0f]
#define HEADER_BACKGROUND_COLOR [UIColor whiteColor]
#define HEADER_LANDSCAPE_FRAME CGRectMake(0, 0, 1024.0f, 125.0f)
#define HEADER_PORTRAIT_FRAME CGRectMake(0, 0, 768.0f, 125.0f)
#define HEADER_LOGO_FRAME CGRectMake( 30.0f, 0, 200.0f, 125.0f)

#define NAME_LABEL_COLOR [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]
#define NAME_LABEL_BACKGROUND_COLOR [UIColor clearColor]
#define NAME_LABEL_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:40.0f]

#define COUNTRY_LABEL_COLOR [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]
#define COUNTRY_LABEL_BACKGROUND_COLOR [UIColor clearColor]
#define COUNTRY_LABEL_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:20.0f]

#define POSITION_LABEL_COLOR [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]
#define POSITION_LABEL_BACKGROUND_COLOR [UIColor clearColor]
#define POSITION_LABEL_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:50.0f]

#define SCORE_LABEL_COLOR [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]
#define SCORE_LABEL_BACKGROUND_COLOR [UIColor clearColor]
#define SCORE_LABEL_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:45.0f]

#define LABEL_BIGGEST_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:120.0f];
#define LABEL_BIG_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:76.0f];

#define H1_LABEL_COLOR [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]
#define H1_LABEL_BACKGROUND_COLOR [UIColor clearColor]
#define H1_LABEL_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:40.0f]

#define H2_LABEL_COLOR [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]
#define H2_LABEL_BACKGROUND_COLOR [UIColor clearColor]
#define H2_LABEL_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:30.0f]

#define H3_LABEL_COLOR [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]
#define H3_LABEL_BACKGROUND_COLOR [UIColor clearColor]
#define H3_LABEL_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:25.0f]

#define H4_LABEL_COLOR [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]
#define H4_LABEL_BACKGROUND_COLOR [UIColor clearColor]
#define H4_LABEL_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:20.0f]

#define MENU_BUTTON_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:40.0f]
#define MENU_BUTTON_FONT_COLOR [UIColor cyanColor]

#define THUMB_TEXT_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:80.0f]
#define THUMB_TEXT_COLOR [UIColor whiteColor]
#define THUMB_TEXT_BACKGROUND_COLOR [UIColor orangeColor]

#define LIST_CONTENT_LANDSCAPE_HEIGHT CGSizeMake(599.0f, 599.0f)
#define LIST_CONTENT_PORTRAIT_HEIGHT CGSizeMake(855.0, 855.0f)
#define LIST_LANDSCAPE_FRAME CGRectMake(0, 125.0f, 1024.0f, 623.0f)
#define LIST_LANDSCAPE_FRAME_OUTSIDE CGRectMake(-1024.0f, 125.0f, 1024.0f, 623.0f)
#define LIST_PORTRAIT_FRAME CGRectMake(0, 125.0f, 768.0f, 879.0f)
#define LIST_PORTRAIT_FRAME_OUTSIDE CGRectMake(-768.0f, 125.0f, 768.0f, 879.0f)
#define LIST_OFFSET_Y 125.0f

#define CONTENT_SCROLL_LANDSCAPE_FRAME CGRectMake(0, 125.0f, 1024.0f, 498.0f)
//#define CONTENT_SCROLL_PORTRAIT_FRAME CGRectMake(0, 125.0f, 768.0f, 754.0f)
#define CONTENT_SCROLL_PORTRAIT_FRAME CGRectMake(0, 125.0f, 768.0f, 754.0f)

#define PALLETE_WHITE_FOR_BACKGROUND [UIColor whiteColor]
#define PALLETE_BLACK_FOR_BACKGROUND [UIColor blackColor]
#define PALLETE_WHITE_FOR_ELEMENTS [UIColor whiteColor]
#define PALLETE_BLACK_FOR_ELEMENTS [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f]
#define PALLETE_CLEAR [UIColor clearColor]

#define PALLETE_AUXILIARY_COLOR_A [UIColor lightGrayColor]

#define PALLETE_BASE_COLOR_A [UIColor colorWithRed:255.0f / 255.0f green:128.0f / 255.0f blue:77.0f / 255.0f alpha:1.0f]    // ORANGE
#define PALLETE_BASE_COLOR_B [UIColor colorWithRed:234.0f / 255.0 green:195.0f / 255.0f blue:78.0f / 255.0f alpha:1.0f]
#define PALLETE_BASE_COLOR_C [UIColor colorWithRed:71.0f / 255.0 green:179.0f / 255.0f blue:157.0f / 255.0f alpha:1.0f]
#define PALLETE_BASE_COLOR_D [UIColor colorWithRed:89.0 / 255.0f green:218.0f / 255.0f blue:154.0f / 255.0f alpha:1.0f]     // LIGHT GREEN
#define PALLETE_BASE_COLOR_E [UIColor colorWithRed:118.0f / 255.0 green:88.0f / 255.0f blue:226.0f / 255.0f alpha:1.0f]     // BLUE
#define PALLETE_BASE_COLOR_F [UIColor colorWithRed:204.0f / 255.0 green:111.0f / 255.0f blue:215.0f / 255.0f alpha:1.0f]    // MAGENTA
#define PALLETE_BASE_COLOR_G [UIColor colorWithRed:0.0f green:193.0f / 255.0f blue:226.0f / 255.0f alpha:1.0f]              // CYAN
#define PALLETE_BASE_COLOR_H [UIColor colorWithRed:234.0f / 255.0 green:195.0f / 255.0f blue:78.0f / 255.0f alpha:1.0f]     // GOLD
#define PALLETE_BASE_COLOR_I [UIColor colorWithRed:0.9f green:0.9f blue:0.9 alpha:1.0f]
#define PALLETE_BASE_COLOR_J [UIColor colorWithRed:228.0f / 255.0 green:87.0f / 255.0f blue:121.0f / 255.0f alpha:1.0f]     // RED

#define PALLETE_BASE_COLOR_FOR_TEXT [UIColor blackColor]

@protocol ClientLayoutable <NSObject>

@property (assign) CGFloat offsetX;
@property (assign) CGFloat offsetY;
@property (assign) CGFloat prefferedWidth;
@property (assign) CGFloat prefferedHeight;

@optional

@property (nonatomic) CGRect frame;

@end

@interface ClientEngine : NSObject

@property (nonatomic, assign) UIDeviceOrientation currentOrientation;
@property (assign) CGRect screenRectPortrait;
@property (assign) CGRect screenRectLandscape;

- (void) startEngine;
- (BOOL) mustConsiderHeader;
- (void) setMustConsiderHeader:(BOOL) consider;
- (void) addLine:(LineModel *) line;
- (UIDeviceOrientation) currentOrientation;
- (void) setCurrentOrientation:(UIDeviceOrientation) newOrientation;
- (CGRect) headerRect;
- (CGRect) screenRect;
- (CGPoint) getOriginForLineIndex:(NSInteger) lineIndex andColumnIndex:(NSInteger) columnIndex;
- (CGPoint) getOriginForLine:(LineModel *) line andColumn:(ColumnModel *) column;
- (CGFloat) getActualLineOffset;
- (void) applyFrame:(id <ClientLayoutable>) label withLine:(LineModel *) line andColumn:(ColumnModel *) column;
- (void) setSpacingAfterHeader:(CGFloat) spacing;



@end
