//
//  AppDelegate.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/18/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AppDelegate.h"

// tests
#import "GroupModel.h"
#import "CountryModel.h"
#import "MetalModel.h"
#import "ProducerModel.h"
#import "ClientModel.h"
#import "ProductModel.h"
#import "AgencyModel.h"
#import "RoleModel.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    FMDBDataAccess *db = [FMDBDataAccess getInstance];
    [db getSchema];
    
    GroupModel *group = [GroupModel loadModel:4];
    NSLog( @"Group: %@", group.name );

    CountryModel *country = [CountryModel loadModel:1];
    NSLog( @"Country: %@", country.name );
    
    MetalModel *metal = [MetalModel loadModel:4];
    NSLog( @"Metal: %@", metal.name );
    
    ProducerModel *producer = [ProducerModel loadModel:3];
    NSLog( @"Producer: %@", producer.name );
    
    ClientModel *client = [ClientModel loadModel:3];
    NSLog( @"Client: %@", client.name );
    
    ProductModel *product = [ProductModel loadModel:2];
    NSLog( @"Product: %@", product.name );
    
    AgencyModel *agency = [AgencyModel loadModel:7];
    NSLog( @"Agency: %@", agency.name );
    
    RoleModel *role = [RoleModel loadModel:7];
    NSLog( @"Role: %@", role.name );
}


@end
