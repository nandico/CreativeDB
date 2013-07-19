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

@interface ImportView()

@property (strong, nonatomic) WebView *webviewContent;

@end

@implementation ImportView

- (id)init
{
    self = [super init];
    if (self)
    {
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
        
        // test
        NSString * path = [[NSBundle mainBundle] bundlePath];
        NSURL * baseURL = [NSURL fileURLWithPath:path];
        
        [[self.webviewContent mainFrame] loadHTMLString:@"<body bgcolor='red'><b>Teste</b>Teste<b>Teste</b></body>" baseURL:baseURL];
    }
    
    return _webviewContent;
}


@end
