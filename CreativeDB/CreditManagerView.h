//
//  CreditManagerView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 4/22/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerView.h"
#import "ManagerEngine.h"
#import "ManagerHeader.h"

@protocol CreditDataSource <NSObject>

- (NSString *) modelTitle;
- (NSString *) modelName;
- (NSNumber *) modelItem;
- (NSMutableDictionary *) fieldData;

@end

@interface CreditManagerView : BaseManagerView

@property (strong) id <CreditDataSource> dataSource;
@property (nonatomic, strong) ManagerEngine *engine;
@property (nonatomic, strong) ManagerHeader *header;
@property (nonatomic, strong) ManagerActionBar *actionBar;

- (void) createForm;
- (void) destroyForm;

@end
