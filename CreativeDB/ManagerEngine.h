//
//  ManagerEngine.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagerFieldContainer.h"
#import "ManagerActionBar.h"
#import "ManagerHeader.h"

typedef enum ManagerFieldType : NSInteger ManagerFieldType;
enum ManagerFieldType : NSInteger {
    MLETextFieldType,
    MLEComboFieldType,
    MLEStaticComboFieldType,
    MLETextAreaFieldType,
    MLEManyComboFieldType
};

typedef enum ManagerFieldDataType : NSInteger ManagerFieldDataType;
enum ManagerFieldDataType : NSInteger {
    MLEGenericDataType,
    MLENumericDataType
};

#define MLE_BACKGROUND_COLOR [NSColor whiteColor]

#define MLE_FIELDSET_OFFSET_Y 50.0f

#define MLE_CONTAINER_WIDTH 450.0f
#define MLE_CONTAINER_HEIGHT 32.0f
#define MLE_TEXTAREA_CONTAINER_HEIGHT 108.0f
#define MLE_CONTAINER_CORNER_RADIUS 5.0f
#define MLE_CONTAINER_SPACING 5.0f

#define MLE_FIELD_ALPHA 1.0f

#define MLE_FIELD_OFFSET_X 90.0f
#define MLE_FIELD_OFFSET_Y 3.0f
#define MLE_FIELD_WIDTH 350.0f
#define MLE_FIELD_HEIGHT 25.0f
#define MLE_TEXT_FIELD_HEIGHT 100.0f
#define MLE_FIELD_FONT [NSFont fontWithName : @ "Montserrat-Regular" size : 12.0f]
#define MLE_FIELD_COLOR [NSColor colorWithCalibratedRed:0.2f green:0.2f blue:0.2f alpha:MLE_FIELD_ALPHA]

#define MLE_FILTER_FIELD_OFFSET_X 10.0f
#define MLE_FILTER_FIELD_OFFSET_Y 3.0f
#define MLE_FILTER_FIELD_WIDTH 180.0f
#define MLE_FILTER_FIELD_HEIGHT 25.0f
#define MLE_FILTER_COMBO_WIDTH 180.0f
#define MLE_FILTER_COMBO_HEIGHT 27.0f

#define MLE_FILTER_CONTAINER_WIDTH 200.0f
#define MLE_FILTER_CONTAINER_HEIGHT 32.0f
#define MLE_FILTER_CONTAINER_OFFSET_X 810.0f
#define MLE_FILTER_CONTAINER_OFFSET_Y 3.0f


#define MLE_HEADER_OFFSET_X 5.0f
#define MLE_HEADER_OFFSET_Y 0.0f
#define MLE_HEADER_WIDTH 450.0f
#define MLE_HEADER_HEIGHT 25.0f
#define MLE_HEADER_FONT [NSFont fontWithName : @ "Montserrat-Regular" size : 16.0f]
#define MLE_HEADER_COLOR [NSColor colorWithCalibratedRed:0.3f green:0.3f blue:0.3f alpha:1.0f]

#define MLE_LABEL_OFFSET_X 5.0f
#define MLE_LABEL_OFFSET_Y 0.0f
#define MLE_LABEL_WIDTH 80.0f
#define MLE_LABEL_HEIGHT 25.0f
#define MLE_LABEL_FONT [NSFont fontWithName : @ "Montserrat-Regular" size : 11.0f]
#define MLE_LABEL_COLOR [NSColor colorWithCalibratedRed:0.3f green:0.3f blue:0.3f alpha:1.0f]

#define MLE_REGULARTABLE_FONT [NSFont fontWithName : @ "Montserrat-Regular" size : 12.0f]
#define MLE_SMALLTABLE_FONT [NSFont fontWithName : @ "Montserrat-Regular" size : 10.0f]
#define MLE_BIGTABLE_FONT [NSFont fontWithName : @ "Montserrat-Regular" size : 26.0f]

#define MLE_BUTTON_WIDTH 80.0f
#define MLE_BUTTON_HEIGHT 35.0f
#define MLE_BUTTON_OFFSET_X 10.0f
#define MLE_BUTTON_OFFSET_Y -3.0f
#define MLE_BUTTON_FONT [NSFont fontWithName : @ "Montserrat-Regular" size : 12.0f]

#define MLE_MENU_BUTTON_WIDTH 100.0f
#define MLE_MENU_BUTTON_HEIGHT 80.0f
#define MLE_MENU_BUTTON_OFFSET_X 10.0f
#define MLE_MENU_BUTTON_OFFSET_Y 530.0f
#define MLE_MENU_BUTTON_FONT [NSFont fontWithName : @ "Montserrat-Regular" size : 16.0f]

#define MLE_SUBMENU_BUTTON_WIDTH 80.0f
#define MLE_SUBMENU_BUTTON_HEIGHT 40.0f
#define MLE_SUBMENU_BUTTON_OFFSET_X 10.0f
#define MLE_SUBMENU_BUTTON_OFFSET_Y 490.0f
#define MLE_SUBMENU_BUTTON_FONT [NSFont fontWithName : @ "Montserrat-Regular" size : 11.0f]

#define MLE_COMBO_WIDTH 350.0f
#define MLE_COMBO_HEIGHT 27.0f
#define MLE_COMBO_FONT [NSFont fontWithName : @ "Montserrat-Regular" size : 12.0f]
#define MLE_COMBO_COLOR [NSColor colorWithCalibratedRed:0.2f green:0.2f blue:0.2f alpha:MLE_FIELD_ALPHA]

#define MLE_FIELD_NAME_KEY @"FIELD_NAME_KEY"
#define MLE_FIELD_LABEL_KEY @"FIELD_LABEL_KEY"
#define MLE_FIELD_TYPE_KEY @"FIELD_TYPE_KEY"
#define MLE_FIELD_DATATYPE_KEY @"FIELD_DATATYPE_KEY"
#define MLE_FIELD_LOOKUP_NAME_KEY @"FIELD_LOOKUP_NAME_KEY"
#define MLE_FIELD_LOOKUP_MODEL_KEY @"FIELD_LOOKUP_MODEL_KEY"
#define MLE_FIELD_STATIC_DOMAIN_KEY @"FIELD_STATIC_DOMAIN_KEY"
#define MLE_FIELD_TABLENAME_KEY @"FIELD_TABLENAME_KEY"

#define MLE_FIELDSET_MODEL_HEADERTITLE @"MLE_FIELDSET_MODEL_HEADERTITLE"
#define MLE_FIELDSET_MODEL_KEY @"FIELDSET_MODEL_KEY"
#define MLE_FIELDSET_MODEL_ITEM @"FIELDSET_MODEL_ITEM"
#define MLE_FIELDSET_MODEL_FILTERNAME @"FIELDSET_MODEL_FILTERNAME"
#define MLE_FIELDSET_MODEL_FILTERVALUE @"FIELDSET_MODEL_FILTERVALUE"

#define MLE_CONTAINER_COLOR [NSColor colorWithCalibratedRed:0.58f green:0.58f blue :0.58f alpha:0.2f]

#define MLE_NOTIFICATION_NEW @"NOTIFICATION_NEW"
#define MLE_NOTIFICATION_SAVE @"NOTIFICATION_SAVE"
#define MLE_NOTIFICATION_DELETE @"NOTIFICATION_DELETE"
#define MLE_NOTIFICATION_PREVIOUS @"NOTIFICATION_PREVIOUS"
#define MLE_NOTIFICATION_NEXT @"NOTIFICATION_NEXT"

@interface ManagerEngine : NSObject

- (void) addFieldContainer:(ManagerFieldContainer *) container;
- (void) addActionBar:(ManagerActionBar *) actionBar;
- (void) addHeader:(ManagerHeader *) header;
- (void) arrangeContainers;
- (void) removeContainers;

@end
