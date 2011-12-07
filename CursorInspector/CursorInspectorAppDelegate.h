//
//  CursorInspectorAppDelegate.h
//  CursorInspector
//
//  Created by nim305 on 09/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CursorInspectorAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    NSTimer *timer;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSString *quickHash;
@property (assign) IBOutlet NSString *superFastHash;
@property (assign) IBOutlet NSString *dimensions;
@property (assign) IBOutlet NSString *analysisResult;
@property (assign) IBOutlet NSImage *image;
@property (assign) BOOL fnDown;

- (void)copyString:(NSString *)string;
- (IBAction)copyButton:(id)sender;

@end
