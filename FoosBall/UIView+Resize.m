//
//  UIView+Resize.m
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "UIView+Resize.h"
#import <QuartzCore/QuartzCore.h>

#define CONRNER_RADIUS 5.0f

@implementation UIView (Resize)

- (void)roundRectCorners {
    self.layer.cornerRadius = CONRNER_RADIUS;
}

- (void)roundedCornersWithBorder {
    [self roundRectCorners];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)makeCircle {
    self.layer.cornerRadius = CGRectGetWidth(self.frame)/2.0f;
}

@end
