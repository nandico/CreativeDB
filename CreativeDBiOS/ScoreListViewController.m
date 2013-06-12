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
#import "UserInfoCell.h"

@interface ScoreListViewController ()

@property (nonatomic, strong) BaseView *viewInstance;
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic) UIDeviceOrientation currentOrientation;

@end

@implementation ScoreListViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view = self.viewInstance = [[BaseView alloc] init];
        
        [ScoreModel setTableName:@"aa_person_score"];
        _items = [ScoreModel loadRankingByTableName:[ScoreModel tableName]];

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
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        self.tableView.frame = LIST_LANDSCAPE_FRAME;
        _currentOrientation = orientation;
    }
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
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductCellIdentifier];
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductCellIdentifier];
    
    if (cell == nil) {
        //cell = [[UserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductCellIdentifier];
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
    
    cell.name.text = item.person.name;
    cell.country.text = item.person.country.name;
    cell.position.text = [self addSuffixToNumber:(indexPath.row + 1 )];
    cell.score.text = [NSString stringWithFormat:@"%@ pts", [item.score stringValue]];
    cell.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [item.person.country.iso lowercaseString]]];
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
