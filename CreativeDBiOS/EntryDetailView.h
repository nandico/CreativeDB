//
//  EntryDetailView.h
//  CreativeDB
//
//  Created by Fernando Aquino on 6/13/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "H1Label.h"
#import "H2Label.h"
#import "H3Label.h"
#import "H4Label.h"
#import "EntryModel.h"
#import "AwardModel.h"
#import "ClientEngine.h"

@interface EntryDetailView : UIView <ClientLayoutable>

@property (assign) CGFloat offsetX;
@property (assign) CGFloat offsetY;
@property (assign) CGFloat prefferedWidth;
@property (assign) CGFloat prefferedHeight;

@property (strong, nonatomic) EntryModel *selectedEntry;
@property (strong, nonatomic) AwardModel *selectedAward;

@property (strong, nonatomic) H1Label *year;
@property (strong, nonatomic) H2Label *metal;
@property (strong, nonatomic) H3Label *entry;
@property (strong, nonatomic) H3Label *client;
@property (strong, nonatomic) H3Label *product;
@property (strong, nonatomic) H1Label *festival;
@property (strong, nonatomic) H3Label *category;
@property (strong, nonatomic) H3Label *subcategory;

- (void) updateData;

@end
