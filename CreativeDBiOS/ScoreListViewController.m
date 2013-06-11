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

        [self createList];
    }
    return self;
}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
        self.tableView.frame = LIST_PORTRAIT_FRAME;
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        self.tableView.frame = LIST_LANDSCAPE_FRAME;
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
    [self.tableView setContentSize:[self.tableView frame].size];
    [self.viewInstance addSubview:self.tableView];
    [self.tableView reloadData];
  
    NSLog( @"contentsize width: %f, height: %f, bounds width: %f, height: %f", self.tableView.contentSize.width, self.tableView.contentSize.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height );
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ProductCellIdentifier = @"ProductCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductCellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    ScoreModel *item = [_items objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", item.person.name];
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
