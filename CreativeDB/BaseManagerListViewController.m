//
//  BaseManagerListViewController.m
//  CreativeDB
//
//  Created by Fernando Aquino on 4/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "BaseManagerListViewController.h"

@interface BaseManagerListViewController ()

@end

@implementation BaseManagerListViewController

- (id) packNSNull:(id) value
{
    if( value )
    {
        return value;
    }
    else
    {
        return [NSNull null];
    }
}

- (id) unpackNSNull:(id) value
{
    if( value == (id)[NSNull null] )
    {
        return nil;
    }
    else
    {
        return value;
    }
}

@end
