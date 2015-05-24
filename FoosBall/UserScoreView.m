//
//  UserScoreView.m
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "UserScoreView.h"
#import "UIView+Resize.h"

@interface UserScoreView()
@property (weak, nonatomic) IBOutlet UIButton *decreaseBtn;
@property (weak, nonatomic) IBOutlet UIButton *increaseBtn;
- (IBAction)decreaseAction:(id)sender;
- (IBAction)increaseAction:(id)sender;
@end

@implementation UserScoreView


- (void) awakeFromNib {
    [self.decreaseBtn makeCircle];
    [self.increaseBtn makeCircle];
}
+ (instancetype)loadFromNib {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([UserScoreView class])
                                bundle:nil];
    return [nib instantiateWithOwner:nil options:nil].firstObject;
}

- (instancetype)awakeAfterUsingCoder:(NSCoder *)aDecoder {
    if ([self subviews].count == 0) {
        UserScoreView *userScoreView = [UserScoreView loadFromNib];
        userScoreView.translatesAutoresizingMaskIntoConstraints = YES;
        return userScoreView;
    } else {
        return self;
    }
}


- (IBAction)decreaseAction:(id)sender {
}

- (IBAction)increaseAction:(id)sender {
}
@end
