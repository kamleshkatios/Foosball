//
//  WelcomeHeader.m
//  FoosBall
//
//  Created by kamlesh on 5/23/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "WelcomeHeader.h"

@implementation WelcomeHeader


+ (instancetype) loadFromNib {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([WelcomeHeader class]) bundle:nil];
    return [nib instantiateWithOwner:nil options:nil].firstObject;
}

@end
