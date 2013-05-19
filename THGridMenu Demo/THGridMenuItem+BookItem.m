//
//  THGridMenuItem+BookItem.m
//  THGridMenu Demo
//
//  Created by Troy HARRIS on 5/17/13.


#import "THGridMenuItem+BookItem.h"

@implementation THGridMenuItem (BookItem)

-(void)addTitle:(NSString *)title {
    self.backgroundColor = [UIColor whiteColor];
    CGRect parentFrame = self.frame;
    CGFloat margin = 10.0;
    CGRect titleFrame = CGRectMake(margin, 0.0, parentFrame.size.width - (margin *2), parentFrame.size.height);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    titleLabel.text = title;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.contentMode = UIViewContentModeScaleAspectFit;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:titleLabel];
}

@end
