//
//  CursorInspectorAppDelegate.m
//  CursorInspector
//
//  Created by nim305 on 09/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CursorInspectorAppDelegate.h"
#import "NMCursorUtils.h"

@implementation CursorInspectorAppDelegate

@synthesize window, quickHash, superFastHash, dimensions, fnDown, image;

- (void)timerRoutine
{
    if (!self.fnDown) {
        NSCursor *c=[NSCursor currentSystemCursor];
        self.quickHash=[[NSNumber numberWithUnsignedInteger:[c quickHash]] stringValue];
        self.superFastHash=[[NSNumber numberWithUnsignedInteger:[c superFastHash]] stringValue];
        self.image=[c image];
        self.dimensions=[NSString stringWithFormat:@"%.0f x %.0f", self.image.size.width, self.image.size.height];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSFlagsChangedMask handler:^(NSEvent *event){
        self.fnDown=([event modifierFlags]&NSFunctionKeyMask)!=0;
        NSLog(@"boo %d", self.fnDown);
    }];
     
    [window setLevel:NSFloatingWindowLevel];
    // Insert code here to initialize your application
    timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerRoutine) userInfo:0 repeats:YES];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
    return YES;
}

@end
