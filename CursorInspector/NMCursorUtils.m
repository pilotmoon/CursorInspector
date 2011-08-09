//
//  NMCursorUtils.m
//  NMKit
//
//  Created by nim305 on 09/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "NMCursorUtils.h"
#import "NMSuperFastHash.h"

@implementation NSCursor (NMCursorUtils)

// really basic hash of cursor (from original DwellClick code)
- (NSUInteger)quickHash
{
#define QUICKHASH_MAX_BYTES 1024
    // get own image
    NSBitmapImageRep * const rep=[[[self image] representations] objectAtIndex:0];
    // the data
    const char * const data=(const char *)[rep bitmapData];
    // how many bytes
	const NSInteger bytesPerPlane=[rep bytesPerPlane];
    // limit for safety
	const NSInteger bytesToCount=bytesPerPlane>QUICKHASH_MAX_BYTES?QUICKHASH_MAX_BYTES:bytesPerPlane;
    // quick hash loop
    const NSInteger pixels=bytesToCount/sizeof(NSUInteger);
	NSUInteger sum=0;
	for(NSUInteger i=0; i<pixels; i++)
	{
        const NSUInteger pixelData=((NSUInteger *)data)[i];
		sum+=(pixelData%91)*i;
	}
	return sum;
}

// better(?) hash using SuperFastHash
- (NSUInteger)superFastHash
{
#define SUPERFASTHASH_MAX_BYTES 16384 //64*64*4
    // get own image
    NSBitmapImageRep * const rep=[[[self image] representations] objectAtIndex:0];
    // the data
    const char * const data=(const char *)[rep bitmapData];
    // how many bytes
	const NSInteger bytesInImage=[rep bytesPerPlane]*[rep numberOfPlanes];
    // limit for safety
	const int bytesToCount=bytesInImage>SUPERFASTHASH_MAX_BYTES?SUPERFASTHASH_MAX_BYTES:(int)bytesInImage;
    // do hash
	return NMSuperFastHash(data,bytesToCount);
}

@end
