//
//  ManagerEngine.h
//  CreativeDB
//
//  Created by Fernando Aquino on 3/29/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagerFieldContainer.h"

typedef enum ManagerFieldType : NSInteger ManagerFieldType;
enum ManagerFieldType : NSInteger {
    MLETextFieldType,
    MLEComboFieldType
};

#define MLE_FIELDSET_OFFSET_Y 100.0f

#define MLE_CONTAINER_WIDTH 500.0f
#define MLE_CONTAINER_HEIGHT 32.0f
#define MLE_CONTAINER_CORNER_RADIUS 5.0f
#define MLE_CONTAINER_SPACING 5.0f

#define MLE_FIELD_OFFSET_X 140.0f
#define MLE_FIELD_OFFSET_Y 3.0f
#define MLE_FIELD_WIDTH 350.0f
#define MLE_FIELD_HEIGHT 25.0f

#define MLE_LABEL_OFFSET_X 5.0f
#define MLE_LABEL_OFFSET_Y 0.0f
#define MLE_LABEL_WIDTH 130.0f
#define MLE_LABEL_HEIGHT 25.0f

#define MLE_FIELD_NAME_KEY @"FIELD_NAME_KEY"
#define MLE_FIELD_LABEL_KEY @"FIELD_LABEL_KEY"
#define MLE_FIELD_TYPE_KEY @"FIELD_TYPE_KEY"
#define MLE_FIELD_VALUE_KEY @"FIELD_VALUE_KEY"
#define MLE_FIELD_MODEL_KEY @"FIELD_MODEL_KEY"
#define MLE_FIELD_NAME_SELECTOR @"FIELD_NAME_SELECTOR"

#define MLE_FIELDSET_MODEL_KEY @"FIELDSET_MODEL_KEY"

#define MLE_CONTAINER_COLOR colorWithCalibratedRed:150.0f / 255.0f green:150.0f / 255.0f blue :150.0f / 255.0f alpha:0.2f

@interface ManagerEngine : NSObject

- (void) addFieldContainer:(ManagerFieldContainer *)container;
- (void) arrangeContainers;

@end
