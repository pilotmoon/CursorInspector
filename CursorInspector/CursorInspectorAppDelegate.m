//
//  CursorInspectorAppDelegate.m
//  CursorInspector
//
//  Created by nim305 on 09/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CursorInspectorAppDelegate.h"
#import "NMCursorUtils.h"
#import "AnalyseCursor.h"

@implementation CursorInspectorAppDelegate

@synthesize window, quickHash, superFastHash, dimensions, fnDown, image, analysisResult;

- (void)timerRoutine
{
    //[NSEvent mouseLocation]
    if (!self.fnDown) {
        NSCursor *c=[NSCursor currentSystemCursor];
        self.quickHash=[[NSNumber numberWithUnsignedInteger:[c quickHash]] stringValue];
        self.superFastHash=[[NSNumber numberWithUnsignedInteger:[c superFastHash]] stringValue];
        self.image=[c image];
        self.dimensions=[NSString stringWithFormat:@"%.0f x %.0f", self.image.size.width, self.image.size.height];
        self.analysisResult=[AnalyseCursor analyseCursorImage:[c image]]?@"YES":@"NO";
    }
}

- (void)handleEvent:(NSEvent *)event
{
    self.fnDown=([event modifierFlags]&NSFunctionKeyMask)!=0;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSFlagsChangedMask|NSLeftMouseUp handler:^(NSEvent *event){
        [self handleEvent:event];
    }];
    [NSEvent addLocalMonitorForEventsMatchingMask:NSFlagsChangedMask|NSLeftMouseUp handler:^(NSEvent *event){
        [self handleEvent:event];
        return event;
    }];
     
    [window setLevel:NSFloatingWindowLevel];

    timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerRoutine) userInfo:0 repeats:YES];
}

- (void)copyString:(NSString *)string
{
    NSPasteboard *pboard=[NSPasteboard generalPasteboard];
    [pboard clearContents];
    [pboard setData:[string dataUsingEncoding:NSUTF8StringEncoding] forType:NSPasteboardTypeString];
}

- (void)copyImage:(NSImage *)img
{
    NSPasteboard *pboard=[NSPasteboard generalPasteboard];
    [pboard clearContents];
    [pboard setData:[img TIFFRepresentation] forType:NSPasteboardTypeTIFF];
}

- (void)copyButton:(id)sender
{
    switch ([sender tag]) {
        case 1:
            [self copyString:self.quickHash];
            break;
        case 2:
            [self copyString:self.superFastHash];
            break;
        case 3:
            [self copyImage:self.image];
            break;
        default:
            break;
    }
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
    return YES;
}

@end
