//
//  THGridMenu.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/12/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THGridMenuItem.h"

@interface THGridMenu : UIScrollView {
    int _columns;
    int _columnInc;
    CGFloat _marginSize;
    CGFloat _gutterSize;
    CGFloat _rowHeight;
    CGFloat _xOffset;
    CGFloat _yOffset;
    UIInterfaceOrientation _rotation;
}

-(id) initWithColumns:(int)col marginSize:(CGFloat)margin gutterSize:(CGFloat)gutter rowHeight:(CGFloat)height;
-(THGridMenuItem *) createMenuItem;
-(void)orientationChange;

@end
