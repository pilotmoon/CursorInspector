//
//  AnalyseCursor.m
//  CursorInspector
//
//  Created by Nicholas Moore on 07/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AnalyseCursor.h"
#import "NMCursorUtils.h"
@implementation AnalyseCursor


typedef struct {
    unsigned char red;
    unsigned char green;
    unsigned char blue;
    unsigned char alpha;
} RGBData;

+ (BOOL)analyseCursorImage:(NSImage *const)image
{
    NSLog(@"getcurs");
    NMSimplifiedCursor *sc=[[NMSimplifiedCursor alloc] initWithImage:image];
    BOOL isbeam=[sc isBeam];
    NSLog(@"is beam %d", isbeam);    
    

    NSLog(@"\n%@", [sc displayString]);

    return isbeam;
}


@end
