//
//  ImportView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 7/16/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ImportView.h"
#import <WebKit/WebKit.h>
#import "BaseManagerCompleteViewController.h"
#import "ManagerTextAreaField.h"
#import "ManagerLabel.h"
#import "ManagerButton.h"

@interface ImportView()

@property (strong, nonatomic) WebView *webviewContent;
@property (strong, nonatomic) ManagerLabel *importLabel;
@property (strong, nonatomic) ManagerTextAreaField *importContent;
@property (strong, nonatomic) ManagerButton *processButton;

@end

@implementation ImportView

- (id)init
{
    self = [super init];
    if (self)
    {
        [self importLabel];
        [self importContent];
        [self processButton];
        [self webviewContent];
    }
    return self;
}

- (WebView *) webviewContent
{
    if( !_webviewContent )
    {
        _webviewContent = [[WebView alloc] init];
        _webviewContent.frame = CGRectMake(0, 0, COMPLETE_VIEW_CONTAINER_WIDTH, COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
        [self addSubview:_webviewContent];

    }
    
    return _webviewContent;
}

- (ManagerLabel *) importLabel
{
    if( !_importLabel )
    {
        _importLabel = [[ManagerLabel alloc] init];
        _importLabel.frame = CGRectMake(_importLabel.frame.origin.x,
                                        430.0f,
                                        COMPLETE_VIEW_CONTAINER_LIST_WIDTH,
                                        _importLabel.frame.size.height);
        [_importLabel setStringValue:@"Source code to import:"];
        [_importLabel setAlignment:NSLeftTextAlignment];
        [self addSubview:_importLabel];
    }
    
    return _importLabel;
}

- (ManagerTextAreaField *) importContent
{
    if( !_importContent )
    {
        _importContent = [[ManagerTextAreaField alloc] init];
        _importContent.frame = CGRectMake(0, COMPLETE_VIEW_CONTAINER_LIST_HEIGHT + 50.0f, COMPLETE_VIEW_CONTAINER_WIDTH, COMPLETE_VIEW_CONTAINER_LIST_HEIGHT);
        [self addSubview:_importContent];
        
    }
    
    return _importContent;
}

- (ManagerButton *) processButton
{
    if(!_processButton)
    {
        _processButton = [[ManagerButton alloc] init];
        _processButton.title = @"Process source code";
        
        _processButton.frame = CGRectMake( 0,
                                          COMPLETE_VIEW_CONTAINER_LIST_HEIGHT + 10.0f,
                                          COMPLETE_VIEW_CONTAINER_LIST_WIDTH,
                                          _processButton.frame.size.height);
        
        [_processButton setTarget:self];
        [_processButton setAction:@selector(processAction)];
        
        [self addSubview:_processButton];
    }
    
    return _processButton;
}

- (void) processAction
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [[self.webviewContent mainFrame] loadHTMLString:[_importContent stringValue] baseURL:baseURL];
}

@end
