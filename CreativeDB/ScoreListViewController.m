//
//  ScoreListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ScoreListViewController.h"
#import "ScoreModel.h"
#import "MenuManagerViewController.h"
#import "ManagerFilterContainer.h"


@interface ScoreListViewController ()

@property (nonatomic, strong) ScoreListView *viewInstance;
@property (nonatomic, strong) NSDictionary *options;

@property (nonatomic, strong) NSScrollView *tableContainer;
@property (nonatomic, strong) NSTableView *tableView;

@property (nonatomic, strong) NSTableColumn *indexColumn;
@property (nonatomic, strong) NSTableColumn *originColumn;
@property (nonatomic, strong) NSTableColumn *countryColumn;
@property (nonatomic, strong) NSTableColumn *scoreColumn;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableDictionary *filters;

@end

@implementation ScoreListViewController

- (id)initWithOptions:(NSDictionary *) options
{
    self = [super init];
    if (self) {
        
        _options = options;
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_KEY] )
            self.modelName = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_KEY]];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_ITEM] )
            self.modelItem = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_ITEM]];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERNAME] )
            self.modelFilterName = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_FILTERNAME]];
        
        if( [self.options objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE] )
            self.modelFilterValue = [self unpackNSNull:[self.options objectForKey:MLE_FIELDSET_MODEL_FILTERVALUE]];
        
        self.view = self.viewInstance = [[ScoreListView alloc] init];
        self.viewInstance.dataSource = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showReports:)
                                                     name:MENU_REPORTS object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateFilter:)
                                                     name:MLE_NOTIFICATION_FILTER_COMBO_UPDATE object:self.viewInstance];
        
        
        
        [self createFilter];
        
        [self createList];
    }
    
    return self;
}

- (void) showReports:(NSNotification *) notification
{
    NSString *tableName = [notification.userInfo objectForKey:MLE_FIELD_TABLENAME_KEY];
    
    if( tableName )
    {
        [ScoreModel setTableName:tableName];
        _items = [ScoreModel loadRankingByTableName:tableName andFilters:_filters];
        [_tableView reloadData];
    }
}


- (void) createList
{
    [ScoreModel setTableName:@"aa_person_score"];
    _items = [ScoreModel loadRankingByTableName:@"aa_person_score" andFilters:_filters];
    
    _tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_BIGLIST_WIDTH, COMPLETE_VIEW_CONTAINER_BIGLIST_HEIGHT)];
    _tableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, COMPLETE_VIEW_CONTAINER_BIGLIST_WIDTH, COMPLETE_VIEW_CONTAINER_BIGLIST_HEIGHT)];
    
    [_tableView setRowHeight:50.0f];
    
    _indexColumn = [[NSTableColumn alloc] initWithIdentifier:@"index"];
    _originColumn = [[NSTableColumn alloc] initWithIdentifier:@"origin"];
    _countryColumn = [[NSTableColumn alloc] initWithIdentifier:@"country"];
    _scoreColumn = [[NSTableColumn alloc] initWithIdentifier:@"score"];
    
    [_indexColumn setWidth:COMPLETE_VIEW_CONTAINER_BIGLIST_WIDTH / 4.0f];
    [_originColumn setWidth:COMPLETE_VIEW_CONTAINER_BIGLIST_WIDTH / 4.0f];
    [_countryColumn setWidth:COMPLETE_VIEW_CONTAINER_BIGLIST_WIDTH / 4.0f];
    [_scoreColumn setWidth:COMPLETE_VIEW_CONTAINER_BIGLIST_WIDTH / 4.0f];
    
    [_indexColumn.headerCell setStringValue:@"Position"];
    [_originColumn.headerCell setStringValue:@"Origin"];
    [_countryColumn.headerCell setStringValue:@"Country"];
    [_scoreColumn.headerCell setStringValue:@"Score"];
    
    [_tableView addTableColumn:_indexColumn];
    [_tableView addTableColumn:_originColumn];
    [_tableView addTableColumn:_countryColumn];
    [_tableView addTableColumn:_scoreColumn];
    
    [_tableContainer setDocumentView:_tableView];
    [_tableContainer setHasVerticalScroller:YES];
    
    [self.view addSubview:_tableContainer];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    [_tableView reloadData];
    
}

- (void) createFilter
{
    _filters = [[NSMutableDictionary alloc] init];

    self.fieldData = [[NSMutableDictionary alloc] init];
    
    [self prepareEntity];

    [self.viewInstance createForm];
}

- (void) prepareEntity
{
    NSDictionary *country = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                             @"country", MLE_FIELD_NAME_KEY,
                             @"Country", MLE_FIELD_LABEL_KEY,
                             @"CountryModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                             @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                             [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                             [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                             [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                             [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                             nil];
    
    [self.fieldData setObject:country forKey:@"country"];
    
    NSDictionary *agency = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                             @"agency", MLE_FIELD_NAME_KEY,
                             @"Agency", MLE_FIELD_LABEL_KEY,
                             @"AgencyModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                             @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                             [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                             [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                             [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                             [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                             nil];
    
    [self.fieldData setObject:agency forKey:@"agency"];

    NSDictionary *group = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithInteger:MLEComboFieldType], MLE_FIELD_TYPE_KEY,
                            @"group", MLE_FIELD_NAME_KEY,
                            @"Group", MLE_FIELD_LABEL_KEY,
                            @"GroupModel", MLE_FIELD_LOOKUP_MODEL_KEY,
                            @"name", MLE_FIELD_LOOKUP_NAME_KEY,
                            [self packNSNull:self.modelName], MLE_FIELDSET_MODEL_KEY,
                            [self packNSNull:self.modelItem], MLE_FIELDSET_MODEL_ITEM,
                            [self packNSNull:self.modelFilterName], MLE_FIELDSET_MODEL_FILTERNAME,
                            [self packNSNull:self.modelFilterValue], MLE_FIELDSET_MODEL_FILTERVALUE,
                            nil];
    
    [self.fieldData setObject:group forKey:@"group"];
    
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _items.count;
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

- (void) updateFilter:(NSNotification *) notification
{
    ManagerFilterComboBox *combo = [notification.userInfo objectForKey:MLE_FILTER_COMBO_ITEM];
    NSString *value = [combo itemObjectValueAtIndex:[combo indexOfSelectedItem]];
    [_filters setObject:value forKey:combo.name];
    
    NSLog( @"FILTERS UPDATE: %@", _filters );
    
    NSLog( @"Notification: %@", combo.name );
    NSLog( @"Value: %@", value );
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTextField *cell = [tableView makeViewWithIdentifier:@"ScoreView" owner:self];
    
    if (nil == cell) {
        cell = [[NSTextField alloc] initWithFrame:CGRectZero];
        cell.identifier = @"ScoreView";
        [cell setBezeled:NO];
        cell.backgroundColor = MLE_CONTAINER_COLOR;
        cell.wantsLayer = YES;
        cell.layer.cornerRadius = 4.0f;
    }
    
    ScoreModel *item = [_items objectAtIndex:row];

    [cell setFont:MLE_REGULARTABLE_FONT];
    
    if( [tableColumn.identifier isEqualToString:@"index"] )
    {
        [cell setFont:MLE_BIGTABLE_FONT];
        [cell setStringValue:[NSString stringWithFormat:@"%@", [self addSuffixToNumber:( row + 1 )] ]];
    }
    else if( [tableColumn.identifier isEqualToString:@"origin"] )
    {
        if( item.person )
        {
            [cell setStringValue:item.person.name];
        }
        else if( item.agency )
        {
            [cell setStringValue:item.agency.name];
        }
        else if( item.group )
        {
            [cell setStringValue:item.group.name];
        }
        else if( item.client )
        {
            [cell setStringValue:item.client.name];
        }
        else if( item.country )
        {
            [cell setStringValue:item.country.name];
        }
        else if( item.producer )
        {
            [cell setStringValue:item.producer.name];
        }
        else if( item.product )
        {
            [cell setStringValue:item.product.name];
        }
    }
    else if( [tableColumn.identifier isEqualToString:@"country"] )
    {
        if( item.person )
        {
            [cell setStringValue:item.person.country.name];
        }
        else if( item.agency )
        {
            [cell setStringValue:item.agency.country.name];
        }
        else if( item.group )
        {
            [cell setStringValue:@"-"];
        }
        else if( item.client )
        {
            [cell setStringValue:item.client.country.name];
        }
        else if( item.country )
        {
            [cell setStringValue:item.country.name];
        }
        else if( item.producer )
        {
            [cell setStringValue:item.producer.country.name];
        }
        else if( item.product )
        {
            [cell setStringValue:item.product.client.country.name];
        }
    }
    else if( [tableColumn.identifier isEqualToString:@"score"] )
    {
        [cell setStringValue:[item.score stringValue]];
    }
    
    return cell;
}


@end
