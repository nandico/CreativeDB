//
//  ProducerCreditManagerView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/10/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerView.h"
#import "ManagerEngine.h"

@protocol ProducerCreditDataSource <NSObject>

- (NSString *) modelName;
- (NSNumber *) modelItem;
- (NSMutableDictionary *) fieldData;

@end

@interface ProducerCreditManagerView : BaseManagerView

@property (strong) id <ProducerCreditDataSource> dataSource;
@property (nonatomic, strong) ManagerEngine *engine;
@property (nonatomic, strong) ManagerActionBar *actionBar;

- (void) createForm;
- (void) destroyForm;

@end
