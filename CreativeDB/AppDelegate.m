//
//  AppDelegate.m
//  CreativeDB
//
//  Created by Fernando Aquino on 3/18/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "AppDelegate.h"

// temporary data
#import "ManagerEngine.h"

#import "AgencyManagerViewController.h"
#import "EntryManagerViewController.h"
#import "EntryModel.h"

// test data
/*
#import "GroupModel.h"
#import "CountryModel.h"
#import "MetalModel.h"
#import "ClientModel.h"
#import "ProductModel.h"
#import "AgencyModel.h"
#import "RoleModel.h"
#import "CategoryModel.h"
#import "SubcategoryModel.h"
#import "PersonModel.h"
#import "FestivalModel.h"
#import "AwardModel.h"
#import "CreditModel.h"
#import "AwardModel.h"
#import "ProducerCreditModel.h"
#import "AnnotationModel.h"
#import "CalendarTypeModel.h"
#import "CalendarModel.h"
*/

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /*
    FMDBDataAccess *db = [FMDBDataAccess getInstance];
    [db getSchema];
    
    GroupModel *group = [GroupModel loadModel:4];
    NSLog( @"Group: %@", group.name );

    CountryModel *country = [CountryModel loadModel:1];
    NSLog( @"Country: %@", country.name );
    
    MetalModel *metal = [MetalModel loadModel:4];
    NSLog( @"Metal: %@", metal.name );
    
    ProducerModel *producer = [ProducerModel loadModel:2];
    NSLog( @"Producer: %@", producer.name );
    
    ClientModel *client = [ClientModel loadModel:1];
    NSLog( @"Client: %@", client.name );
    
    ProductModel *product = [ProductModel loadModel:2];
    NSLog( @"Product: %@", product.name );
    
    AgencyModel *agency = [AgencyModel loadModel:1];
    NSLog( @"Agency: %@", agency.name );
    
    RoleModel *role = [RoleModel loadModel:7];
    NSLog( @"Role: %@", role.name );
    
    CategoryModel *category = [CategoryModel loadModel:7];
    NSLog( @"Category: %@", category.name );
    
    SubcategoryModel *subcategory = [SubcategoryModel loadModel:9];
    NSLog( @"Subcategory: %@", subcategory.name );
    
    DisciplineModel *discipline = [DisciplineModel loadModel:9];
    NSLog( @"Discipline: %@", discipline.name );
    
    PersonModel *person = [PersonModel loadModel:2];
    NSLog( @"Person: %@", person.name );
    
    FestivalModel *festival = [FestivalModel loadModel:13];
    NSLog( @"Festival: %@", festival.name );
    
    EntryModel *entry = [EntryModel loadModel:1];
    NSLog( @"Entry: %@", entry.name );
    
    AwardModel *award = [AwardModel loadModel:1];
    NSLog( @"Award: %@, %@, %@", award.metal.name, award.entry.name, award.festival.name );
    
    NSMutableArray *credits = entry.credits;
    
    for( CreditModel *credit in credits )
    {
        NSLog( @"Credits: %@, %@", credit.person.name, credit.role.name );
    }
    
    NSMutableArray *producerCredits = entry.producers;
    
    for( ProducerCreditModel *producerCredit in producerCredits )
    {
        NSLog( @"Producer: %@, %@", producerCredit.producer.name, producerCredit.discipline.name );
    }
    
    NSMutableArray *annotations = entry.annotations;
    
    for( AnnotationModel *annotation in annotations )
    {
        NSLog( @"Annotation: %@, %@", annotation.user.name, annotation.comment );
    }
    
    CalendarTypeModel *calendarType = [CalendarTypeModel loadModel:1];
    NSLog( @"Calendar type: %@", calendarType.name );

    CalendarModel *calendar = [CalendarModel loadModel:1];
    NSLog( @"Calendar: %@, %@", calendar.type.name, calendar.date );
    */
    
    /*
    NSDictionary *agencyOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"AgencyModel", MLE_FIELDSET_MODEL_KEY,
                                   [NSNumber numberWithInt:2], MLE_FIELDSET_MODEL_ITEM,
                                   nil];
    
    AgencyManagerViewController *agencyManager = [[AgencyManagerViewController alloc] initWithOptions:agencyOptions];
    agencyManager.view.frame = self.window.frame;
    agencyManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    self.window.contentView = agencyManager.view;
    */
    
    NSDictionary *entryOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"EntryModel", MLE_FIELDSET_MODEL_KEY,
                                  [EntryModel first], MLE_FIELDSET_MODEL_ITEM,
                                  nil];
    
    EntryManagerViewController *entryManager = [[EntryManagerViewController alloc] initWithOptions:entryOptions];
    entryManager.view.frame = self.window.frame;
    entryManager.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    self.window.contentView = entryManager.view;
    
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
    return YES;
}
     


@end
