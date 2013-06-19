//
//  PersonIdView.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/15/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonIdView.h"

@implementation PersonIdView

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        
        [self addSubview:[self userInitials]];
    }
    return self;
}

- (PersonThumbLabel *) userInitials
{
    if( !_userInitials )
    {
        _userInitials = [[PersonThumbLabel alloc] init];
    }
    
    return _userInitials;
}

- (NSString *) extractInitials:(NSString *) name
{
    NSMutableString * foundedLetters = [NSMutableString string];
    NSInteger letterCount = 0;
    
    NSArray * words = [name componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    for (NSString * word in words) {
        if ([word length] > 0 && letterCount < 3 ) {
            NSString * firstLetter = [word substringToIndex:1];
            [foundedLetters appendString:[firstLetter uppercaseString]];
            
            letterCount ++;
        }
    }
    
    return [foundedLetters uppercaseString];
}

@end
