//
//  ScoreListView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/4/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerView.h"
#import "ManagerEngine.h"

@protocol ScoreListDataSource <NSObject>

- (NSString *) modelName;
- (NSNumber *) modelItem;
- (NSMutableDictionary *) fieldData;

@end

@interface ScoreListView : BaseManagerView

@property (assign) id <ScoreListDataSource> dataSource;

- (void) createForm;
- (void) destroyForm;

@end
