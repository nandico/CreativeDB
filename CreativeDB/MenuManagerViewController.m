//
//  MenuManagerViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/19/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "MenuManagerViewController.h"
#import "BaseLayeredView.h"
#import "ManagerMenuButton.h"
#import "ManagerSubmenuButton.h"
#import "ManagerEngine.h"
#import "ScoreController.h"

@interface MenuManagerViewController ()

@property (nonatomic, strong) BaseLayeredView *viewInstance;

@property (nonatomic, strong) ManagerMenuButton *entries;
@property (nonatomic, strong) ManagerMenuButton *agencies;
@property (nonatomic, strong) ManagerMenuButton *groups;
@property (nonatomic, strong) ManagerMenuButton *clients;
@property (nonatomic, strong) ManagerMenuButton *persons;
@property (nonatomic, strong) ManagerMenuButton *roles;
@property (nonatomic, strong) ManagerMenuButton *producers;
@property (nonatomic, strong) ManagerMenuButton *categories;
@property (nonatomic, strong) ManagerMenuButton *subcategories;
@property (nonatomic, strong) ManagerMenuButton *reports;

@property (nonatomic, strong) BaseLayeredView *reportsMenu;
@property (nonatomic, strong) ManagerSubmenuButton *reportsRefresh;
@property (nonatomic, strong) ManagerSubmenuButton *reportsAgency;
@property (nonatomic, strong) ManagerSubmenuButton *reportsClient;
@property (nonatomic, strong) ManagerSubmenuButton *reportsCountry;
@property (nonatomic, strong) ManagerSubmenuButton *reportsGroup;
@property (nonatomic, strong) ManagerSubmenuButton *reportsPerson;
@property (nonatomic, strong) ManagerSubmenuButton *reportsProducer;
@property (nonatomic, strong) ManagerSubmenuButton *reportsProduct;

@property (nonatomic, strong) BaseLayeredView *entriesMenu;
@property (nonatomic, strong) ManagerSubmenuButton *entriesImport;

@property (nonatomic,strong) NSMutableArray *menuButtons;
@property (nonatomic,strong) NSMutableArray *submenuButtons;

@end

@implementation MenuManagerViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[BaseLayeredView alloc] init];
        [self prepareMenu];
        
        _submenuButtons = [[NSMutableArray alloc] init];

        _entriesMenu = [[BaseLayeredView alloc] init];
        _entriesMenu.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        [self.viewInstance addSubview:_entriesMenu];
        [self prepareEntriesSubmenu];
        [_entriesMenu setHidden:NO];
        
        _reportsMenu = [[BaseLayeredView alloc] init];
        _reportsMenu.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        [self.viewInstance addSubview:_reportsMenu];
        [self prepareReportsSubmenu];
        [_reportsMenu setHidden:YES];
    }
    
    return self;
}

- (void) prepareMenu
{
    _menuButtons = [[NSMutableArray alloc] init];
    
    [_menuButtons addObject:[self entries]];
    [_menuButtons addObject:[self agencies]];
    [_menuButtons addObject:[self groups]];
    [_menuButtons addObject:[self clients]];
    [_menuButtons addObject:[self persons]];
    [_menuButtons addObject:[self producers]];
    [_menuButtons addObject:[self roles]];
    [_menuButtons addObject:[self categories]];
    [_menuButtons addObject:[self subcategories]];
    [_menuButtons addObject:[self reports]];
    
    [self arrangeMenu];
}

- (void) arrangeMenu
{
    for( NSInteger i = 0; i < _menuButtons.count; i ++ )
    {
        ManagerMenuButton *button = [_menuButtons objectAtIndex:i];
        
        button.frame = NSMakeRect( MLE_MENU_BUTTON_OFFSET_X + ( button.frame.size.width * i ),
                                  button.frame.origin.y,
                                  button.frame.size.width,
                                  button.frame.size.height);
    }
}

- (void) prepareReportsSubmenu
{
    [_submenuButtons addObject:[self reportsRefresh]];
    [_submenuButtons addObject:[self reportsPerson]];
    [_submenuButtons addObject:[self reportsAgency]];
    [_submenuButtons addObject:[self reportsClient]];
    [_submenuButtons addObject:[self reportsCountry]];
    [_submenuButtons addObject:[self reportsGroup]];
    [_submenuButtons addObject:[self reportsProducer]];
    [_submenuButtons addObject:[self reportsProduct]];
    
    [_reportsMenu addSubview:self.reportsRefresh];
    [_reportsMenu addSubview:self.reportsPerson];
    [_reportsMenu addSubview:self.reportsAgency];
    [_reportsMenu addSubview:self.reportsClient];
    [_reportsMenu addSubview:self.reportsCountry];
    [_reportsMenu addSubview:self.reportsGroup];
    [_reportsMenu addSubview:self.reportsProducer];
    [_reportsMenu addSubview:self.reportsProduct];
    
    [self arrangeSubmenu:_reportsMenu];
}

- (void) prepareEntriesSubmenu
{
    [_submenuButtons addObject:[self entriesImport]];
    
    [_entriesMenu addSubview:self.entriesImport];
    
    [self arrangeSubmenu:_entriesMenu];
}

- (void) arrangeSubmenu:(BaseLayeredView *) submenuView
{
    NSInteger touched = 0;
    
    for( NSInteger i = 0; i < _submenuButtons.count; i ++ )
    {
        ManagerSubmenuButton *button = [_submenuButtons objectAtIndex:i];
        
        if( button.superview == submenuView )
        {
            button.frame = NSMakeRect( MLE_SUBMENU_BUTTON_OFFSET_X + ( button.frame.size.width * touched ),
                                      button.frame.origin.y,
                                      button.frame.size.width,
                                      button.frame.size.height);
            touched ++;
        }
    }
}

- (ManagerMenuButton *) entries
{
    if(!_entries)
    {
        _entries = [[ManagerMenuButton alloc] init];
        _entries.title = @"Entries";
        [_entries setTarget:self];
        [_entries setAction:@selector(entriesAction)];
        [_entries.cell setBackgroundColor:PALLETE_BASE_COLOR_A];
        [self.viewInstance addSubview:_entries];
    }
    
    return _entries;
}

- (ManagerMenuButton *) agencies
{
    if(!_agencies)
    {
        _agencies = [[ManagerMenuButton alloc] init];
        _agencies.title = @"Agencies";
        [_agencies setTarget:self];
        [_agencies setAction:@selector(agenciesAction)];
        [_agencies.cell setBackgroundColor:PALLETE_BASE_COLOR_E];
        [self.viewInstance addSubview:_agencies];
    }
    
    return _agencies;
}

- (ManagerMenuButton *) groups
{
    if(!_groups)
    {
        _groups = [[ManagerMenuButton alloc] init];
        _groups.title = @"Groups";
        [_groups setTarget:self];
        [_groups setAction:@selector(groupsAction)];
        [_groups.cell setBackgroundColor:PALLETE_BASE_COLOR_F];
        [self.viewInstance addSubview:_groups];
    }
    
    return _groups;
}

- (ManagerMenuButton *) clients
{
    if(!_clients)
    {
        _clients = [[ManagerMenuButton alloc] init];
        _clients.title = @"Clients";
        [_clients setTarget:self];
        [_clients setAction:@selector(clientsAction)];
        [_clients.cell setBackgroundColor:PALLETE_BASE_COLOR_H];
        [self.viewInstance addSubview:_clients];
    }
    
    return _clients;
}

- (ManagerMenuButton *) persons
{
    if(!_persons)
    {
        _persons = [[ManagerMenuButton alloc] init];
        _persons.title = @"Persons";
        [_persons setTarget:self];
        [_persons setAction:@selector(personsAction)];
        [_persons.cell setBackgroundColor:PALLETE_BASE_COLOR_D];
        [self.viewInstance addSubview:_persons];
    }
    
    return _persons;
}

- (ManagerMenuButton *) roles
{
    if(!_roles)
    {
        _roles = [[ManagerMenuButton alloc] init];
        _roles.title = @"Roles";
        [_roles setTarget:self];
        [_roles setAction:@selector(rolesAction)];
        [self.viewInstance addSubview:_roles];
    }
    
    return _roles;
}

- (ManagerMenuButton *) producers
{
    if(!_producers)
    {
        _producers = [[ManagerMenuButton alloc] init];
        _producers.title = @"Production";
        [_producers setTarget:self];
        [_producers setAction:@selector(producersAction)];
        [_producers.cell setBackgroundColor:PALLETE_BASE_COLOR_C];
        [self.viewInstance addSubview:_producers];
    }
    
    return _producers;
}

- (ManagerMenuButton *) reports
{
    if(!_reports)
    {
        _reports = [[ManagerMenuButton alloc] init];
        _reports.title = @"Reports";
        [_reports setTarget:self];
        [_reports setAction:@selector(reportsAction)];
        [_reports.cell setBackgroundColor:PALLETE_BASE_COLOR_G];
        [self.viewInstance addSubview:_reports];
    }
    
    return _reports;
}

- (ManagerMenuButton *) categories
{
    if(!_categories)
    {
        _categories = [[ManagerMenuButton alloc] init];
        _categories.title = @"Categories";
        [_categories setTarget:self];
        [_categories setAction:@selector(categoriesAction)];
        [self.viewInstance addSubview:_categories];
    }
    
    return _categories;
}

- (ManagerMenuButton *) subcategories
{
    if(!_subcategories)
    {
        _subcategories = [[ManagerMenuButton alloc] init];
        _subcategories.title = @"Subcategories";
        [_subcategories setTarget:self];
        [_subcategories setAction:@selector(subcategoriesAction)];
        [self.viewInstance addSubview:_subcategories];
    }
    
    return _subcategories;
}

- (ManagerSubmenuButton *) reportsRefresh
{
    if(!_reportsRefresh)
    {
        _reportsRefresh = [[ManagerSubmenuButton alloc] init];
        _reportsRefresh.title = @"REFRESH";
        [_reportsRefresh setTarget:self];
        [_reportsRefresh setAction:@selector(reportsRefreshAction:)];
        [self.viewInstance addSubview:_reportsRefresh];
    }
    
    return _reportsRefresh;
}

- (ManagerSubmenuButton *) reportsPerson
{
    if(!_reportsPerson)
    {
        _reportsPerson = [[ManagerSubmenuButton alloc] init];
        _reportsPerson.title = @"Person";
        _reportsPerson.tableName = @"aa_person_score";
        [_reportsPerson setTarget:self];
        [_reportsPerson setAction:@selector(reportsSubmenuAction:)];
        [self.viewInstance addSubview:_reportsPerson];
    }
    
    return _reportsPerson;
}

- (ManagerSubmenuButton *) reportsAgency
{
    if(!_reportsAgency)
    {
        _reportsAgency = [[ManagerSubmenuButton alloc] init];
        _reportsAgency.title = @"Agency";
        _reportsAgency.tableName = @"aa_agency_score";
        [_reportsAgency setTarget:self];
        [_reportsAgency setAction:@selector(reportsSubmenuAction:)];
        [self.viewInstance addSubview:_reportsAgency];
    }
    
    return _reportsAgency;
}

- (ManagerSubmenuButton *) reportsClient
{
    if(!_reportsClient)
    {
        _reportsClient = [[ManagerSubmenuButton alloc] init];
        _reportsClient.title = @"Client";
        _reportsClient.tableName = @"aa_client_score";
        [_reportsClient setTarget:self];
        [_reportsClient setAction:@selector(reportsSubmenuAction:)];
        [self.viewInstance addSubview:_reportsClient];
    }
    
    return _reportsClient;
}

- (ManagerSubmenuButton *) reportsCountry
{
    if(!_reportsCountry)
    {
        _reportsCountry = [[ManagerSubmenuButton alloc] init];
        _reportsCountry.title = @"Country";
        _reportsCountry.tableName = @"aa_country_score";
        [_reportsCountry setTarget:self];
        [_reportsCountry setAction:@selector(reportsSubmenuAction:)];
        [self.viewInstance addSubview:_reportsCountry];
    }
    
    return _reportsCountry;
}

- (ManagerSubmenuButton *) reportsGroup
{
    if(!_reportsGroup)
    {
        _reportsGroup = [[ManagerSubmenuButton alloc] init];
        _reportsGroup.title = @"Group";
        _reportsGroup.tableName = @"aa_group_score";
        [_reportsGroup setTarget:self];
        [_reportsGroup setAction:@selector(reportsSubmenuAction:)];
        [self.viewInstance addSubview:_reportsGroup];
    }
    
    return _reportsGroup;
}


- (ManagerSubmenuButton *) reportsProducer
{
    if(!_reportsProducer)
    {
        _reportsProducer = [[ManagerSubmenuButton alloc] init];
        _reportsProducer.title = @"Producer";
        _reportsProducer.tableName = @"aa_producer_score";
        [_reportsProducer setTarget:self];
        [_reportsProducer setAction:@selector(reportsSubmenuAction:)];
        [self.viewInstance addSubview:_reportsProducer];
    }
    
    return _reportsProducer;
}

- (ManagerSubmenuButton *) reportsProduct
{
    if(!_reportsProduct)
    {
        _reportsProduct = [[ManagerSubmenuButton alloc] init];
        _reportsProduct.title = @"Product";
        _reportsProduct.tableName = @"aa_product_score";
        [_reportsProduct setTarget:self];
        [_reportsProduct setAction:@selector(reportsSubmenuAction:)];
        [self.viewInstance addSubview:_reportsProduct];
    }
    
    return _reportsProduct;
}

- (void) reportsRefreshAction:(NSNotification *) notification
{
    [ScoreController processAwards];
}

- (void) entriesAction
{
    [_reportsMenu setHidden:YES];
    [_entriesMenu setHidden:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_ENTRIES
                                                        object:self
                                                      userInfo:nil];
}

- (ManagerSubmenuButton *) entriesImport
{
    if(!_entriesImport)
    {
        _entriesImport = [[ManagerSubmenuButton alloc] init];
        _entriesImport.title = @"Import";
        [_entriesImport setTarget:self];
        [_entriesImport setAction:@selector(entriesImportAction)];
        [self.viewInstance addSubview:_entriesImport];
    }
    
    return _entriesImport;
}

- (void) entriesImportAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SUBMENU_IMPORT
                                                        object:self
                                                      userInfo:nil];
}


- (void) agenciesAction
{
    [_reportsMenu setHidden:YES];
    [_entriesMenu setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_AGENCIES
                                                        object:self
                                                      userInfo:nil];
}

- (void) groupsAction
{
    [_reportsMenu setHidden:YES];
    [_entriesMenu setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_GROUPS
                                                        object:self
                                                      userInfo:nil];
}


- (void) clientsAction
{
    [_reportsMenu setHidden:YES];
    [_entriesMenu setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_CLIENTS
                                                        object:self
                                                      userInfo:nil];
}

- (void) personsAction
{
    [_reportsMenu setHidden:YES];
    [_entriesMenu setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_PERSONS
                                                        object:self
                                                      userInfo:nil];
}

- (void) rolesAction
{
    [_reportsMenu setHidden:YES];
    [_entriesMenu setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_ROLES
                                                        object:self
                                                      userInfo:nil];
}

- (void) producersAction
{
    [_reportsMenu setHidden:YES];
    [_entriesMenu setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_PRODUCERS
                                                        object:self
                                                      userInfo:nil];
}

- (void) categoriesAction
{
    [_reportsMenu setHidden:YES];
    [_entriesMenu setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_CATEGORIES
                                                        object:self
                                                      userInfo:nil];
}

- (void) subcategoriesAction
{
    [_reportsMenu setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_SUBCATEGORIES
                                                        object:self
                                                      userInfo:nil];
}

- (void) reportsAction
{
    [_reportsMenu setHidden:NO];
    [_entriesMenu setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_REPORTS
                                                        object:self
                                                      userInfo:nil];
}

- (void) reportsSubmenuAction:( ManagerSubmenuButton * )sender
{
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:sender.tableName forKey:MLE_FIELD_TABLENAME_KEY];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_REPORTS
                                                        object:self
                                                      userInfo:userInfo];

}

@end
