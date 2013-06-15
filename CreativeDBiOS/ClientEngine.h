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

#define NOTIFICATION_WAKE_PERSON_DETAIL @"NOTIFICATION_WAKE_PERSON_DETAIL"
#define NOTIFICATION_WAKE_SCORE @"NOTIFICATION_WAKE_SCORE"

#define PERSON_ITEM @"PERSON_ITEM"

#define SCREEN_LANDSCAPE_FRAME CGRectMake(0, 0, 1024.0f, 768.0f)
#define SCREEN_PORTRAIT_FRAME CGRectMake(0, 0, 768.0f, 1024.0f)

#define HEADER_TITLE_COLOR [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f]
#define HEADER_TITLE_BACKGROUND_COLOR nil
#define HEADER_TITLE_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:46.0f]
#define HEADER_BACKGROUND_COLOR [UIColor blackColor]
#define HEADER_LANDSCAPE_FRAME CGRectMake(0, 0, 1024.0f, 80.0f)
#define HEADER_PORTRAIT_FRAME CGRectMake(0, 0, 768.0f, 80.0f)
#define HEADER_LOGO_FRAME CGRectMake( 30.0f, 0, 200.0f, 80.0f)

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

#define LIST_CONTENT_LANDSCAPE_HEIGHT CGSizeMake(668.0f, 668.0f)
#define LIST_CONTENT_PORTRAIT_HEIGHT CGSizeMake(924.0f, 924.0f)
#define LIST_LANDSCAPE_FRAME CGRectMake(0, 100.0f, 1024.0f, 668.0f)
#define LIST_PORTRAIT_FRAME CGRectMake(0, 100.0f, 768.0f, 924.0f)
#define LIST_OFFSET_Y 100.0f

@protocol ClientLayoutable <NSObject>

@property (assign) CGFloat offsetX;
@property (assign) CGFloat offsetY;
@property (assign) CGFloat prefferedWidth;
@property (assign) CGFloat prefferedHeight;

@optional

@property (nonatomic) CGRect frame;

@end

@interface ClientEngine : NSObject

+ (void) startEngine;
+ (BOOL) mustConsiderHeader;
+ (void) setMustConsiderHeader:(BOOL) consider;
+ (void) addLine:(LineModel *) line;
+ (UIDeviceOrientation) currentOrientation;
+ (void) setCurrentOrientation:(UIDeviceOrientation) newOrientation;
+ (CGRect) headerRect;
+ (CGRect) screenRect;
+ (CGPoint) getOriginForLineIndex:(NSInteger) lineIndex andColumnIndex:(NSInteger) columnIndex;
+ (CGPoint) getOriginForLine:(LineModel *) line andColumn:(ColumnModel *) column;
+ (void) applyFrame:(id <ClientLayoutable>) label withLine:(LineModel *) line andColumn:(ColumnModel *) column;

@end
