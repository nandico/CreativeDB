//
//  ClientEngine.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_NAME @"CreativeDB"

#define HEADER_TITLE_COLOR [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f]
#define HEADER_TITLE_BACKGROUND_COLOR nil
#define HEADER_TITLE_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:46.0f]
#define HEADER_BACKGROUND_COLOR [UIColor blackColor]
#define HEADER_LANDSCAPE_FRAME CGRectMake(0, 0, 1024.0f, 80.0f)
#define HEADER_PORTRAIT_FRAME CGRectMake(0, 0, 768.0f, 80.0f)
#define HEADER_LOGO_FRAME CGRectMake( 30.0f, 0, 200.0f, 80.0f)

#define NAME_LABEL_COLOR [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]
#define NAME_LABEL_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:40.0f]

#define COUNTRY_LABEL_COLOR [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]
#define COUNTRY_LABEL_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:20.0f]

#define POSITION_LABEL_COLOR [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]
#define POSITION_LABEL_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:50.0f]

#define SCORE_LABEL_COLOR [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]
#define SCORE_LABEL_FONT [UIFont fontWithName:@"LeagueGothic-Regular" size:45.0f]

#define LIST_CONTENT_LANDSCAPE_HEIGHT CGSizeMake(668.0f, 668.0f)
#define LIST_CONTENT_PORTRAIT_HEIGHT CGSizeMake(924.0f, 924.0f)
#define LIST_LANDSCAPE_FRAME CGRectMake(0, 100.0f, 1024.0f, 668.0f)
#define LIST_PORTRAIT_FRAME CGRectMake(0, 100.0f, 768.0f, 924.0f)

@interface ClientEngine : NSObject

@end
