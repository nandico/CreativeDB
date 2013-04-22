//
//  CreditManagerView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 4/22/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerView.h"

@protocol CreditDataSource <NSObject>

- (NSString *) modelName;
- (NSNumber *) modelItem;
- (NSMutableDictionary *) fieldData;

@end

@interface CreditManagerView : BaseManagerView

@property (strong) id <CreditDataSource> dataSource;

- (void) createForm;
- (void) destroyForm;

@end
