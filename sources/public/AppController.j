/*
 * AppController.j
 * NewApplication
 *
 * Created by You on July 5, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>

@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc]
        initWithContentRect:CGRectMakeZero() 
        styleMask:CPBorderlessBridgeWindowMask],
    contentView = [theWindow contentView];
    
    [contentView setBackgroundColor:[CPColor blackColor]];    

    [theWindow orderFront:self];
    
}

@end
