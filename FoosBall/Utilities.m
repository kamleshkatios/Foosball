//
//  Utilities.m
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+  (CGFloat)screenHeight {
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    return CGRectGetHeight(screenFrame);
}

+  (CGFloat)screenWidth {
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    return CGRectGetWidth(screenFrame);
}

@end
