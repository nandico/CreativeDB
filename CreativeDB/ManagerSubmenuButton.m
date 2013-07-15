//
//  ManagerSubmenuButton.m
//  CreativeDB
//
//  Created by Fernando Aquino on 5/28/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ManagerSubmenuButton.h"
#import "ManagerEngine.h"
#import "ManagerMenuButtonCell.h"

@implementation ManagerSubmenuButton

- (id)init
{
    self = [super init];
    if (self) {
        self.cell = [[ManagerMenuButtonCell alloc] init];
        self.frame = NSMakeRect( MLE_SUBMENU_BUTTON_OFFSET_X, MLE_SUBMENU_BUTTON_OFFSET_Y, MLE_SUBMENU_BUTTON_WIDTH, MLE_SUBMENU_BUTTON_HEIGHT );
        [self setFont:MLE_SUBMENU_BUTTON_FONT];
    }
    
    return self;
}

- (void) setTitle:(NSString *)aString
{
    NSColor *color = [NSColor whiteColor];
    NSMutableAttributedString *colorTitle =
    [[NSMutableAttributedString alloc] initWithString:aString];
    
    NSRange titleRange = NSMakeRange(0, [colorTitle length]);
    
    [colorTitle addAttribute:NSForegroundColorAttributeName
                       value:color
                       range:titleRange];
    
    [colorTitle addAttribute:NSFontAttributeName value:MLE_SUBMENU_BUTTON_FONT range:titleRange];
    
    NSMutableParagraphStyle *centredStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [centredStyle setAlignment:NSCenterTextAlignment];
    
    [colorTitle addAttribute:NSParagraphStyleAttributeName value:centredStyle range:titleRange];
    
    [super setAttributedTitle:colorTitle];
}

@end
