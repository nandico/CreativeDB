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

@end

@implementation ScoreListViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[BaseView alloc] init];
        
        [ScoreModel setTableName:@"aa_person_score"];
        _items = [ScoreModel loadRankingByTableName:[ScoreModel tableName]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(wakeUpScore)
                                                     name:NOTIFICATION_WAKE_SCORE object:nil];

        [self createList];
    }
    return self;
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
        self.tableView.frame = LIST_PORTRAIT_FRAME;
        _currentOrientation = orientation;
        [self.tableView reloadData];
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        self.tableView.frame = LIST_LANDSCAPE_FRAME;
        _currentOrientation = orientation;
        [self.tableView reloadData];
    }
}

- (void) wakeUpScore
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

    NSDictionary *updateMessage = [NSDictionary dictionaryWithObject:scoreEntry.person forKey:PERSON_ITEM];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WAKE_PERSON_DETAIL
                                                        object:self
                                                      userInfo:updateMessage];
    
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
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", item.person.name];
    
    cell.dataSource = self;
    cell.name.text = item.person.name;
    cell.country.text = item.person.country.name;
    cell.position.text = [NSString stringWithFormat:@"    %@", [self addSuffixToNumber:([item.person.rankingGlobal longValue])]];
    cell.score.text = [NSString stringWithFormat:@"%@ pts", [item.score stringValue]];
    cell.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [item.person.country.iso lowercaseString]]];

    [cell layoutSubviews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
