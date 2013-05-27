//
//  AwardManagerView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/12/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerView.h"
#import "ManagerEngine.h"
#import "ManagerHeader.h"

@protocol AwardDataSource <NSObject>

- (NSString *) modelTitle;
- (NSString *) modelName;
- (NSNumber *) modelItem;
- (NSMutableDictionary *) fieldData;

@end

@interface AwardManagerView : BaseManagerView

@property (strong) id <AwardDataSource> dataSource;
@property (nonatomic, strong) ManagerEngine *engine;
@property (nonatomic, strong) ManagerHeader *header;
@property (nonatomic, strong) ManagerActionBar *actionBar;

- (void) createForm;
- (void) destroyForm;

@end
