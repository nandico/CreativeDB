//
//  BaseManagerCompleteViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/23/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define COMPLETE_VIEW_OFFSET_X 10.0f
#define COMPLETE_VIEW_OFFSET_Y 20.0f
#define COMPLETE_VIEW_CONTAINER_WIDTH 460.0f
#define COMPLETE_VIEW_CONTAINER_HEIGHT 500.0f
#define COMPLETE_VIEW_CONTAINER_LIST_WIDTH 450.0f
#define COMPLETE_VIEW_CONTAINER_LIST_HEIGHT 190.0f
#define COMPLETE_VIEW_CONTAINER_MEDIUMLIST_WIDTH 500.0f
#define COMPLETE_VIEW_CONTAINER_MEDIUMLIST_HEIGHT 471.0f
#define COMPLETE_VIEW_CONTAINER_BIGLIST_WIDTH 800.0f
#define COMPLETE_VIEW_CONTAINER_BIGLIST_HEIGHT 470.0f
#define COMPLETE_VIEW_CONTAINER_HEADER_HEIGHT 459.0f

@interface BaseManagerCompleteViewController : NSViewController

- (id) packNSNull:(id) value;

@end
