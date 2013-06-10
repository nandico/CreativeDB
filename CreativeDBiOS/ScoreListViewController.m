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
        
        NSLog( @"Items: %@", _items );
        
        [self createList];
    }
    return self;
}

- (void) createList
{
    NSLog( @"Frame: %f, %f, %f, %f", self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height );
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 1024, 668) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.viewInstance addSubview:self.tableView];
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
