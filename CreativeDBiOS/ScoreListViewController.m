//
//  ScoreListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ScoreListViewController.h"
#import "BaseView.h"
#import "ScoreModel.h"
#import "ClientEngine.h"

@interface ScoreListViewController ()

@property (nonatomic, strong) BaseView *viewInstance;
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSString *selectedTable;
@end

@implementation ScoreListViewController

- (id)init
{
    self = [super init];
    if (self) {

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(wakeUpPeopleScore)
                                                     name:NOTIFICATION_WAKE_PERSON_SCORE object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(wakeUpAgenciesScore)
                                                     name:NOTIFICATION_WAKE_AGENCIES_SCORE object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(wakeUpEntriesScore)
                                                     name:NOTIFICATION_WAKE_ENTRIES_SCORE object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(wakeUpClientsScore)
                                                     name:NOTIFICATION_WAKE_CLIENTS_SCORE object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(wakeUpCountriesScore)
                                                     name:NOTIFICATION_WAKE_COUNTRIES_SCORE object:nil];

        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(wakeUpGroupsScore)
                                                     name:NOTIFICATION_WAKE_GROUPS_SCORE object:nil];

        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(wakeUpProducersScore)
                                                     name:NOTIFICATION_WAKE_PRODUCERS_SCORE object:nil];

    }
    return self;
}

- (void) loadView
{
    self.view = self.viewInstance = [[BaseView alloc] initWithFrame:CONTENT_LANDSCAPE_FRAME];
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
        if( self.tableView.frame.origin.x == 0 )
        {
            self.tableView.frame = LIST_PORTRAIT_FRAME;
        }
        else
        {
            self.tableView.frame = LIST_PORTRAIT_FRAME_OUTSIDE;
        }
        
        _currentOrientation = orientation;
        [self.tableView reloadData];
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        if( self.tableView.frame.origin.x == 0 )
        {
            self.tableView.frame = LIST_LANDSCAPE_FRAME;
        }
        else
        {
            self.tableView.frame = LIST_LANDSCAPE_FRAME_OUTSIDE;
        }
        
        _currentOrientation = orientation;
        [self.tableView reloadData];
    }
}

- (void) wakeUpPeopleScore
{
    [self loadScoreTable:@"aa_person_score"];
    [self wakeUpAnimation];
}

- (void) wakeUpAgenciesScore
{
    [self loadScoreTable:@"aa_agency_score"];
    [self wakeUpAnimation];
}

- (void) wakeUpEntriesScore
{
    [self loadScoreTable:@"aa_entry_score"];
    [self wakeUpAnimation];
}

- (void) wakeUpClientsScore
{
    [self loadScoreTable:@"aa_client_score"];
    [self wakeUpAnimation];
}

- (void) wakeUpCountriesScore
{
    [self loadScoreTable:@"aa_country_score"];
    [self wakeUpAnimation];
}

- (void) wakeUpGroupsScore
{
    [self loadScoreTable:@"aa_group_score"];
    [self wakeUpAnimation];
}

- (void) wakeUpProducersScore
{
    [self loadScoreTable:@"aa_producer_score"];
    [self wakeUpAnimation];
}

- (void) wakeUpAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];

    CGRect frame = self.tableView.bounds;
    
    self.tableView.frame = CGRectMake( 0,
                                      LIST_OFFSET_Y,
                                      frame.size.width,
                                      frame.size.height );
    [UIView commitAnimations];
    
}

- (void) loadScoreTable:(NSString *) tableName
{
    _selectedTable = tableName;
    
    [ScoreModel setTableName:_selectedTable];
    _items = [ScoreModel loadRankingByTableName:[ScoreModel tableName]];

    [self.tableView reloadData];
}

- (void) createList
{
    self.tableView = [[UITableView alloc] initWithFrame:LIST_LANDSCAPE_FRAME style:UITableViewStylePlain];
    self.tableView.scrollEnabled = YES;
    self.tableView.delaysContentTouches = YES;
    self.tableView.userInteractionEnabled = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setRowHeight:130.0f];
    [self.tableView setContentSize:[self.tableView frame].size];
    [self.viewInstance addSubview:self.tableView];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ProductCellIdentifier = @"ProductCellIdentifier";
    
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductCellIdentifier];
    
    if (cell == nil) {
        cell = [[UserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductCellIdentifier];

    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(NSString *) addSuffixToNumber:( long ) number
{
    NSString *suffix;
    int ones = number % 10;
    int temp = floor(number/10.0);
    int tens = temp%10;
    
    if (tens ==1) {
        suffix = @"th";
    } else if (ones ==1){
        suffix = @"st";
    } else if (ones ==2){
        suffix = @"nd";
    } else if (ones ==3){
        suffix = @"rd";
    } else {
        suffix = @"th";
    }
    
    NSString *completeAsString = [NSString stringWithFormat:@"%ld%@",number,suffix];
    
    return completeAsString;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScoreModel *scoreEntry = [_items objectAtIndex:[indexPath indexAtPosition:1] ];

    if( scoreEntry.person )
    {
        NSDictionary *updateMessage = [NSDictionary dictionaryWithObject:scoreEntry.person forKey:NOTIFICATION_ITEM];
    
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_PERSON_DETAIL
                                                            object:self
                                                          userInfo:updateMessage];
        [self animateExit];
    }
    else if( scoreEntry.agency )
    {
        NSDictionary *updateMessage = [NSDictionary dictionaryWithObject:scoreEntry.agency forKey:NOTIFICATION_ITEM];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_AGENCIES_DETAIL
                                                            object:self
                                                          userInfo:updateMessage];
        [self animateExit];
    }
    else if( [ScoreModel.tableName isEqualToString:@"aa_entry_score"] )
    {
        NSDictionary *updateMessage = [NSDictionary dictionaryWithObject:scoreEntry.entry forKey:NOTIFICATION_ITEM];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_ENTRIES_DETAIL
                                                            object:self
                                                          userInfo:updateMessage];
        [self animateExit];
    }
    else if( scoreEntry.client )
    {
        NSDictionary *updateMessage = [NSDictionary dictionaryWithObject:scoreEntry.client forKey:NOTIFICATION_ITEM];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_CLIENTS_DETAIL
                                                            object:self
                                                          userInfo:updateMessage];
        [self animateExit];

    }
    else if( [ScoreModel.tableName isEqualToString:@"aa_country_score"] )
    {
        NSDictionary *updateMessage = [NSDictionary dictionaryWithObject:scoreEntry.country forKey:NOTIFICATION_ITEM];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_COUNTRIES_DETAIL
                                                            object:self
                                                          userInfo:updateMessage];
        [self animateExit];
    }
    else if( scoreEntry.group )
    {
        NSDictionary *updateMessage = [NSDictionary dictionaryWithObject:scoreEntry.group forKey:NOTIFICATION_ITEM];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_GROUPS_DETAIL
                                                            object:self
                                                          userInfo:updateMessage];
        [self animateExit];

    }
    else if( scoreEntry.producer )
    {
        NSDictionary *updateMessage = [NSDictionary dictionaryWithObject:scoreEntry.producer forKey:NOTIFICATION_ITEM];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_PRODUCERS_DETAIL
                                                            object:self
                                                          userInfo:updateMessage];
        [self animateExit];

    }

    
}

- (void) animateExit
{
    CGRect frame = self.tableView.bounds;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    
    self.tableView.frame = CGRectMake( frame.origin.x - frame.size.width,
                                      LIST_OFFSET_Y,
                                      frame.size.width,
                                      frame.size.height );
    [UIView commitAnimations];

}


- (void)configureCell:(UserInfoCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    ScoreModel *item = [_items objectAtIndex:indexPath.row];
    
    cell.dataSource = self;
    
    if( item.person.name )
    {
        cell.name.text = item.person.name;
        [cell.thumb.userInitials setText:[cell.thumb extractInitials:item.person.name]];
        cell.country.text = item.person.country.name;
        cell.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [item.person.country.iso lowercaseString]]];
        cell.position.text = [NSString stringWithFormat:@"%@", [self addSuffixToNumber:([item.person.rankingGlobal longValue])]];
    }
    else if( item.agency.name )
    {
        cell.name.text = item.agency.name;
        [cell.thumb.userInitials setText:[cell.thumb extractInitials:item.agency.name]];
        cell.country.text = item.agency.country.name;
        cell.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [item.agency.country.iso lowercaseString]]];
        //cell.position.text = [NSString stringWithFormat:@"%@", [self addSuffixToNumber:(indexPath.row + 1)]];
        cell.position.text = [NSString stringWithFormat:@"%@", [self addSuffixToNumber:([item.agency.rankingGlobal longValue])]];
        
    }
    else if( item.client.name )
    {
        cell.name.text = item.client.name;
        [cell.thumb.userInitials setText:[cell.thumb extractInitials:item.client.name]];
        cell.country.text = item.client.country.name;
        cell.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [item.client.country.iso lowercaseString]]];
        cell.position.text = [NSString stringWithFormat:@"%@", [self addSuffixToNumber:([item.client.rankingGlobal longValue])]];

    }
    else if( item.group.name )
    {
        cell.name.text = item.group.name;
        [cell.thumb.userInitials setText:[cell.thumb extractInitials:item.group.name]];
        cell.country.text = item.group.country.name;
        cell.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [item.group.country.iso lowercaseString]]];;
        cell.position.text = [NSString stringWithFormat:@"%@", [self addSuffixToNumber:(indexPath.row + 1)]];

    }
    else if( item.producer.name )
    {
        cell.name.text = item.producer.name;
        [cell.thumb.userInitials setText:[cell.thumb extractInitials:item.producer.name]];
        cell.country.text = item.producer.country.name;
        cell.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [item.producer.country.iso lowercaseString]]];
        cell.position.text = [NSString stringWithFormat:@"%@", [self addSuffixToNumber:([item.producer.rankingGlobal longValue])]];

    }
    else if( [item.entry.pk isEqualToNumber:item.origin] )
    {
        cell.name.text = item.entry.name;
        [cell.thumb.userInitials setText:[cell.thumb extractInitials:item.entry.name]];
        cell.country.text = [NSString stringWithFormat:@"%@ - %@", item.country.name, item.entry.agency.name];
        cell.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [item.country.iso lowercaseString]]];
        cell.position.text = [NSString stringWithFormat:@"%@", [self addSuffixToNumber:(indexPath.row + 1)]];
        
    }
    else if( [item.country.pk isEqualToNumber:item.country.pk] )
    {
        cell.name.text = item.country.name;
        [cell.thumb.userInitials setText:item.country.iso3];
        cell.country.text = item.country.name;
        cell.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [item.country.iso lowercaseString]]];
        cell.position.text = [NSString stringWithFormat:@"%@", [self addSuffixToNumber:(indexPath.row + 1)]];

    }
    
    cell.score.text = [NSString stringWithFormat:@"%@ pts", [item.score stringValue]];

    cell.selectionStyle = UITableViewCellSelectionStyleGray;
     
    [cell layoutSubviews];
}

- (void)viewDidLoad
{
    [ScoreModel setTableName:@"aa_person_score"];
    _items = [ScoreModel loadRankingByTableName:[ScoreModel tableName]];
    
    [self createList];

    self.viewInstance.clipsToBounds = YES;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
