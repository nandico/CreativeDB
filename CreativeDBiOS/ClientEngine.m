//
//  ClientEngine.m
//  CreativeDB
//
//  Created by Fernando Aquino on 6/9/13.
//  Copyright (c) 2013 Cacau. All rights reserved.
//

#import "ClientEngine.h"

@interface ClientEngine()

@property (nonatomic, assign) UIDeviceOrientation orientation;
@property (nonatomic, strong) NSMutableArray *lines;
@property (nonatomic, assign) BOOL considerHeader;
@property (nonatomic, assign) CGFloat spacingAfterHeader;

@end

@implementation ClientEngine

- (void) startEngine
{
    _screenRectPortrait = SCREEN_PORTRAIT_FRAME;
    _screenRectLandscape = SCREEN_LANDSCAPE_FRAME;
    _considerHeader = YES; // default behavior
    _spacingAfterHeader = 30.0f;
    
    _lines = [[NSMutableArray alloc] init];
}

- (void) setSpacingAfterHeader:(CGFloat) spacing
{
    _spacingAfterHeader = spacing;
}

- (BOOL) mustConsiderHeader
{
    return _considerHeader;
}

- (void) setMustConsiderHeader:(BOOL) consider
{
    _considerHeader = consider;
}

- (void) addLine:(LineModel *) line
{
    line.lineIndex = [_lines count];
    [_lines addObject:line];
}

- (CGPoint) getOriginForLineIndex:(NSInteger) lineIndex andColumnIndex:(NSInteger) columnIndex
{
    LineModel *line = [_lines objectAtIndex:lineIndex];
    
    if( line )
    {
        ColumnModel *column = [line.columns objectAtIndex:columnIndex];
        
        if( column )
        {
            return [self getOriginForLine:line andColumn:column];
        }
    }

    return CGPointZero;
}

- (CGPoint) getOriginForLine:(LineModel *) line andColumn:(ColumnModel *) column
{
    CGFloat lineOffset = 0;
    
    if( _considerHeader )
    {
        lineOffset += [self headerRect].size.height + _spacingAfterHeader;
    }
        
    for( LineModel *cursorLine in _lines )
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
            break;
        }
        
        columnOffset += [self absoluteWidthForColumn:cursorColumn andLine:line];
    }
    
    return CGPointMake( columnOffset, lineOffset );
}

- (CGFloat) getActualLineOffset
{
    CGFloat lineOffset = 0;
    
    if( _considerHeader )
    {
        lineOffset += [self headerRect].size.height + _spacingAfterHeader;
    }
    
    for( LineModel *cursorLine in _lines )
    {
        lineOffset += [cursorLine.height floatValue];
    }

    return lineOffset;
}

- (void) applyFrame:(id <ClientLayoutable>) label withLine:(LineModel *) line andColumn:(ColumnModel *) column;
{
    CGPoint flatOrigin = [self getOriginForLine:line andColumn:column];
    CGFloat columnWidth = 0;
    CGFloat columnHeight = 0;
    
    columnWidth = ( [label prefferedWidth] ) ? [label prefferedWidth] : ( [self absoluteWidthForColumn:column andLine:line] - [label offsetX] );
    columnHeight = ( [label prefferedHeight] ) ? [label prefferedHeight] : [line.height floatValue];
    
    label.frame = CGRectMake(flatOrigin.x + [label offsetX],
                             flatOrigin.y + [label offsetY],
                             columnWidth, columnHeight );
}

- (CGFloat) absoluteWidthForColumn:(ColumnModel *) column andLine:(LineModel *) line
{
    if( column.width )
    {
        return [column.width floatValue];
    }
    else if( column.percentWidth )
    {
        CGFloat fixedColumnsTotal = [self calculateFixedColumnsTotal:line];

        return floor( [column.percentWidth floatValue] / 100.0f * ( [self screenRect].size.width - fixedColumnsTotal ) );
    }
    
    return 0;
}

- (CGFloat) calculateFixedColumnsTotal:(LineModel *) line
{
    CGFloat total = 0;
    
    for( ColumnModel *column in line.columns )
    {
        if( column.width ) total += [column.width floatValue];
    }
    
    return total;
}

- (UIDeviceOrientation) currentOrientation
{
    return _orientation;
}

- (void) setCurrentOrientation:(UIDeviceOrientation) newOrientation
{
    _orientation = newOrientation;
}

- (CGRect) headerRect
{
    if( UIDeviceOrientationIsLandscape( _orientation ) )
    {
        return HEADER_LANDSCAPE_FRAME;
    }
    else if( UIDeviceOrientationIsPortrait( _orientation ) )
    {
        return HEADER_PORTRAIT_FRAME;
    }
    
    return CGRectZero;
}

- (CGRect) screenRect
{
    if( UIDeviceOrientationIsLandscape( _orientation ) )
    {
        return _screenRectLandscape;
    }
    else if( UIDeviceOrientationIsPortrait( _orientation ) )
    {
        return _screenRectPortrait;
    }
    
    NSLog( @"ORIENTATION IS EMPTY %d", _orientation );
    
    return CGRectZero;
}

@end
