//
//  ClientManagerViewController.h
//  CreativeDB
//
//  Created by Fernando Aquino on 5/23/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerViewController.h"
#import "ClientManagerView.h"

#define CLIENT_MANAGER_UPDATE_LIST @"CLIENT_MANAGER_UPDATE_LIST"
#define CLIENT_MANAGER_UPDATE_VIEW @"CLIENT_MANAGER_UPDATE_VIEW"
#define CLIENT_MANAGER_UPDATE_CREDITS @"CLIENT_MANAGER_UPDATE_CREDITS"

@interface ClientManagerViewController : BaseManagerViewController <ClientDataSource>

@property (nonatomic, strong) NSString *modelTitle;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSNumber *modelItem;
@property (nonatomic, strong) NSMutableDictionary *fieldData;

- (id)initWithOptions:(NSDictionary *)options;


@end
