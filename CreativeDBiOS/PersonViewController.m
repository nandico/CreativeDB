//
//  PersonViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/12/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonViewController.h"
#import "ClientEngine.h"
#import "ColumnModel.h"
#import "LineModel.h"

@interface PersonViewController ()

@property (strong, nonatomic) PersonView *viewInstance;
@property (strong, nonatomic) UIScrollView *scrollView;

@property (nonatomic) UIDeviceOrientation currentOrientation;

@property (nonatomic, strong) NSMutableArray *entryLines;
@property (nonatomic, strong) H1Label *titleEntries;

@property (nonatomic, strong) ClientEngine *engine;

@end

@implementation PersonViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        _engine = [[ClientEngine alloc] init];
        _entryLines = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) loadView
{
    self.view = self.viewInstance = [[PersonView alloc] initWithFrame:CONTENT_LANDSCAPE_FRAME];
}

- (void)viewDidLoad
{
    [self scrollView];
    [self titleEntries];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateData:)
                                                 name:NOTIFICATION_WAKE_PERSON_DETAIL object:nil];
    
    [super viewDidLoad];
}

- (void) updateData:(NSNotification *) notification
{
    self.selectedPerson = [notification.userInfo objectForKey:PERSON_ITEM];
    
    if( self.selectedPerson )
    {
        [self removeData];
        self.viewInstance.dataSource = self;
        [self.viewInstance updateData];
        [self.viewInstance updateOrientation:_currentOrientation];
        [self updateEntries];
    }
}

- (void) removeData
{
    [_titleEntries removeFromSuperview];
    
    for( EntryDetailView *entry in _entryLines )
    {
        [entry removeFromSuperview];
    }
}

- (void) updateEntries
{
    NSInteger awardIndex = 0;
    
    [_engine startEngine];
    [_engine setMustConsiderHeader:NO];
    [_engine setSpacingAfterHeader:0.0f];
    
    [_engine setCurrentOrientation:_currentOrientation];
    
    ColumnModel *column = [[ColumnModel alloc] initWithPercent:@100];
    LineModel *line = [[LineModel alloc] initWithOptions:
                       [NSMutableArray arrayWithObjects:column, nil ]];
    line.height = @100;
    [_engine addLine:line];
    _titleEntries.offsetX = APP_LEFT_PADDING;
    _titleEntries.text = @"Entries";
    [_engine applyFrame:_titleEntries withLine:line andColumn:column];

    [self.scrollView addSubview:_titleEntries];
    
    
    for( EntryModel *entry in _selectedPerson.entries )
    {
        for( AwardModel *award in entry.awards )
        {
            ColumnModel *column = [[ColumnModel alloc] initWithPercent:@100];
            LineModel *line = [[LineModel alloc] initWithOptions:
                    [NSMutableArray arrayWithObjects:column, nil ]];
            line.height = @180;
            [_engine addLine:line];
            
            EntryDetailView *entryView = [[EntryDetailView alloc] init];
            
            [entryView updateOrientation:_currentOrientation];
            
            [_engine applyFrame:entryView withLine:line andColumn:column];
            //entryView.frame = CGRectMake(0, 150 * awardIndex, 1024, 1024 );
                        
            entryView.selectedEntry = entry;
            entryView.selectedAward = award;
            [entryView updateData];
            
            [self.scrollView addSubview:entryView];
            
            [_entryLines addObject:entryView];
            
            awardIndex ++;
        }
    }
    
    [_scrollView setContentSize:CGSizeMake(0.0f, [_engine getActualLineOffset])];

}

- (void) updateOrientation:( UIDeviceOrientation ) orientation;
{
    
    _currentOrientation = orientation;
    
    if( UIDeviceOrientationIsPortrait( orientation ) )
    {
        NSLog( @"Applying portrait." );
        
        self.scrollView.frame = CONTENT_SCROLL_PORTRAIT_FRAME;
        [self removeData];
        self.viewInstance.dataSource = self;
        [self.viewInstance updateData];
        [self.viewInstance updateOrientation:_currentOrientation];
        [self updateEntries];
        //self.viewInstance.clipsToBounds = YES;
        [self updateChildOrientation:orientation];
        //self.scrollView.contentOffset = CGPointMake( 768.0f, 754.0f );

        
    }
    else if( UIDeviceOrientationIsLandscape( orientation ) )
    {
        NSLog( @"Applying landscape." );
        
        self.scrollView.frame = CONTENT_SCROLL_LANDSCAPE_FRAME;
        [self removeData];
        self.viewInstance.dataSource = self;
        [self.viewInstance updateData];
        [self.viewInstance updateOrientation:_currentOrientation];
        [self updateEntries];
        //self.viewInstance.clipsToBounds = YES;
        [self updateChildOrientation:orientation];
        //self.scrollView.contentOffset = CGPointMake( 1024.0f, 498.0f );

    }


    
}

- (void) updateChildOrientation:( UIDeviceOrientation ) orientation
{
    for( EntryDetailView *child in _entryLines )
    {
        [child updateOrientation:orientation];
    }
}

- (UIScrollView *) scrollView
{
    if( !_scrollView )
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CONTENT_SCROLL_LANDSCAPE_FRAME];
        [self.viewInstance addSubview:_scrollView];
        
    }
    
    [self.view addSubview:_scrollView];
    
    return _scrollView;
}

- (H1Label *) titleEntries
{
    if( !_titleEntries )
    {
        _titleEntries = [[H1Label alloc] init];
    }
    
    return _titleEntries;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
