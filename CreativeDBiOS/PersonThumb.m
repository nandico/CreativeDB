//
//  PersonThumb.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/15/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "PersonThumb.h"

@implementation PersonThumb 

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        
        [self addSubview:[self initials]];
    }
    return self;
}

- (PersonThumbLabel *) initials
{
    if( !_initials )
    {
        _initials = [[PersonThumbLabel alloc] init];
    }
    
    return _initials;
}

- (NSString *) extractInitials:(NSString *) name
{
    NSMutableString * foundedLetters = [NSMutableString string];
    
    NSArray * words = [name componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    for (NSString * word in words) {
        if ([word length] > 0) {
            NSString * firstLetter = [word substringToIndex:1];
            [foundedLetters appendString:[firstLetter uppercaseString]];
        }
    }
    
    return [foundedLetters uppercaseString];
}

@end
