//
//  THGridMenu.m
//  THGridMenu
//
//  Created by Troy HARRIS on 5/12/13.
//

#import "THGridMenu.h"

@implementation THGridMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init {
    
// By default, THGridMenu uses the entire screen.
    CGRect windowSize = [[UIScreen mainScreen] applicationFrame];
    
// To iOS, width is height in landscape
    _rotation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsLandscape(_rotation)) {
        CGFloat width = windowSize.size.height;
        CGFloat height = windowSize.size.width;
        windowSize = CGRectMake(windowSize.origin.x, windowSize.origin.y, width, height);
    }

    self = [super initWithFrame:windowSize];
    if (self) {
        self.scrollEnabled = YES;
        self.userInteractionEnabled = YES;
        self.contentSize = self.frame.size;
        
// Had some problems with scrollbar weirdness when rotating, so enable at your own risk.
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

// Call this method in your view controller
-(id)initWithColumns:(int)col marginSize:(CGFloat)margin gutterSize:(CGFloat)gutter rowHeight:(CGFloat)height{
    self = [self init];
    if (self) {
        _columns = col;
        _marginSize = margin;
        _gutterSize = gutter;
        _rowHeight = height;
        _xOffset = gutter;
        _yOffset = gutter;
    }
    return self;
}

//Recalculate the sizes when the interface rotates
-(void)orientationChange {
    CGFloat deviceWidth;
    CGFloat lastHeight = 0;
    CGFloat newXOrigin = 0;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    //Check to make sure its a real orientation change and not a false positive
    if (orientation != _rotation) {
        if(UIInterfaceOrientationIsLandscape(orientation)) {
            deviceWidth = [UIScreen mainScreen].bounds.size.height;
        } else {
            deviceWidth = [UIScreen mainScreen].bounds.size.width;
        }
        
        self.frame = CGRectMake(0, 0, deviceWidth, self.frame.size.height);
        self.contentSize = CGSizeMake(self.frame.size.width, self.contentSize.height);
        CGFloat newWidth = ((deviceWidth - (_gutterSize * 2)) / _columns) - (_marginSize * (_columns - 1) / _columns);
        NSMutableArray *newViews = [[NSMutableArray alloc] init];
        for (THGridMenuItem *view in self.subviews) {
            if (lastHeight == view.frame.origin.y) {
                newXOrigin = newXOrigin + _marginSize + newWidth;
            } else {
                newXOrigin = view.frame.origin.x;
                lastHeight = view.frame.origin.y;
            }
            view.frame = CGRectMake(newXOrigin, view.frame.origin.y, newWidth, view.frame.size.height);
            [newViews addObject:view];
            [view removeFromSuperview];
        }
        for (THGridMenuItem *view in newViews) {
            [self addSubview:view];
        }
        _rotation = orientation;
    }
}

//The magic. Returns a perfectly sized and origined THGridMenuItem for the view controller to add to the view.
-(THGridMenuItem *) createMenuItem {
    CGFloat adjustedMargin = (_marginSize * (_columns - 1) / _columns);
    CGFloat menuWidth = (self.frame.size.width - (_gutterSize * 2));
    CGFloat itemWidth = (menuWidth / _columns) - adjustedMargin;
    CGRect itemFrame = CGRectMake(_xOffset, _yOffset, itemWidth, _rowHeight);
    THGridMenuItem *item = [[THGridMenuItem alloc] initWithFrame:itemFrame];
    _columnInc++;
    if (_columnInc >= _columns) {
        _columnInc = 0;
        _yOffset = _yOffset + _rowHeight + _marginSize;
        _xOffset = _gutterSize;
    } else {
        _xOffset = _xOffset + _marginSize + itemWidth;
        self.contentSize = CGSizeMake(self.contentSize.width, _yOffset + _marginSize + _rowHeight);
    }
    return item;
}

@end
