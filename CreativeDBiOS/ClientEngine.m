//
//  ClientEngine.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ClientEngine.h"


static UIDeviceOrientation currentOrientation;
static NSMutableArray *lines;
static BOOL considerHeader = YES;
static CGFloat spacingAfterHeader = 30.0f;

@implementation ClientEngine

+ (void) startEngine
{
    lines = [[NSMutableArray alloc] init];
}

+ (BOOL) mustConsiderHeader
{
    @synchronized( self )
    {
        return considerHeader;
    }
}

+ (void) setMustConsiderHeader:(BOOL) consider
{
    @synchronized( self )
    {
        considerHeader = consider;
    }
}

+ (void) addLine:(LineModel *) line
{
    line.lineIndex = [lines count];
    [lines addObject:line];
}

+ (CGPoint) getOriginForLineIndex:(NSInteger) lineIndex andColumnIndex:(NSInteger) columnIndex
{
    LineModel *line = [lines objectAtIndex:lineIndex];
    
    if( line )
    {
        ColumnModel *column = [line.columns objectAtIndex:columnIndex];
        
        if( column )
        {
            return [ClientEngine getOriginForLine:line andColumn:column];
        }
    }

    return CGPointZero;
}

+ (CGPoint) getOriginForLine:(LineModel *) line andColumn:(ColumnModel *) column
{
    CGFloat lineOffset = 0;
    
    if( considerHeader )
    {
        lineOffset += [ClientEngine headerRect].size.height + spacingAfterHeader;
    }
        
    for( LineModel *cursorLine in lines )
    {
        if( cursorLine.lineIndex == line.lineIndex )
        {
            break;
        }
        
        lineOffset += [cursorLine.height floatValue];
    }
    
    CGFloat columnOffset = 0;
    
    
    for( NSInteger columnIndex = 0; columnIndex < [line.columns count]; columnIndex ++ )
    {
        ColumnModel *cursorColumn = [line.columns objectAtIndex:columnIndex];
        if( cursorColumn == column )
        {
//            NSLog( @"Break for column!!" );
            break;
        }
        
        columnOffset += [ClientEngine absoluteWidthForColumn:cursorColumn];
    }
    
    return CGPointMake( columnOffset, lineOffset );
}

+ (void) applyFrame:(id <ClientLayoutable>) label withLine:(LineModel *) line andColumn:(ColumnModel *) column;
{
    CGPoint flatOrigin = [ClientEngine getOriginForLine:line andColumn:column];
    CGFloat columnWidth = 0;
    CGFloat columnHeight = 0;
    
    columnWidth = ( [label prefferedWidth] ) ? [label prefferedWidth] : [ClientEngine absoluteWidthForColumn:column];
    columnHeight = ( [label prefferedHeight] ) ? [label prefferedHeight] : [line.height floatValue];
    
//    NSLog( @"Object: %@", label );
//    NSLog( @"Width: %f, height: %f", columnWidth, columnHeight );
//    NSLog( @"Origin x: %f, y: %f", flatOrigin.x + [label offsetX], flatOrigin.y + [label offsetY] );

    
    label.frame = CGRectMake(flatOrigin.x + [label offsetX],
                             flatOrigin.y + [label offsetY],
                             columnWidth, columnHeight );
}

+ (CGFloat) absoluteWidthForColumn:(ColumnModel *) column
{
    if( column.width )
    {
//        NSLog( @"Returning absolute width: %f", [column.width floatValue] );
        return [column.width floatValue];
    }
    else if( column.percentWidth )
    {
//        NSLog( @"Percent width: %f Screen size width: %f", [column.percentWidth floatValue], [ClientEngine screenRect].size.width );
//        NSLog( @"Returning percent calculated width: %f", [column.percentWidth floatValue] / 100.0f * [ClientEngine screenRect].size.width );
        
        return floor( [column.percentWidth floatValue] / 100.0f * [ClientEngine screenRect].size.width );
    }
    
    return 0;
}

+ (UIDeviceOrientation) currentOrientation
{
    @synchronized( self )
    {
        return currentOrientation;
    }
}

+ (void) setCurrentOrientation:(UIDeviceOrientation) newOrientation
{
    @synchronized( self )
    {
        currentOrientation = newOrientation;
    }
}

+ (CGRect) headerRect
{
    @synchronized( self )
    {
        if( UIDeviceOrientationIsLandscape( currentOrientation ) )
        {
            return HEADER_LANDSCAPE_FRAME;
        }
        else if( UIDeviceOrientationIsPortrait( currentOrientation ) )
        {
            return HEADER_PORTRAIT_FRAME;
        }
        
        return CGRectZero;
    }
}

+ (CGRect) screenRect
{
    @synchronized( self )
    {
        if( UIDeviceOrientationIsLandscape( currentOrientation ) )
        {
            return SCREEN_LANDSCAPE_FRAME;
        }
        else if( UIDeviceOrientationIsPortrait( currentOrientation ) )
        {
            return SCREEN_PORTRAIT_FRAME;
        }
        
//        NSLog( @"ORIENTATION IS EMPTY %d", currentOrientation );
        
        return CGRectZero;
    }
    
}

@end
