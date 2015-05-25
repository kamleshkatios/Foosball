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

@property (nonatomic, copy) ScoreChangedCallBack scoreChangedCallBack;

@property (weak, nonatomic) IBOutlet UIButton *decreaseBtn;
@property (weak, nonatomic) IBOutlet UIButton *increaseBtn;
@property (weak, nonatomic) IBOutlet UILabel *pointLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
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

- (void)updateScoreCard {
    self.pointLbl.text = [NSString stringWithFormat:@"%ld",self.pointCount];
}

- (void)setPlayer:(Player *)player andCallback:(ScoreChangedCallBack) scoreChangedCallBack {
    self.player = player;
    self.nameLbl.text = player.playerName;
    self.scoreChangedCallBack = scoreChangedCallBack;
    self.pointCount = 0;
    [self updateScoreCard];
}

- (IBAction)decreaseAction:(id)sender {
    if (self.pointCount == 0) {
        return;
    }
    self.pointCount--;
    [self updateScoreCard];
    self.scoreChangedCallBack(NO);
}

- (IBAction)increaseAction:(id)sender {
    self.pointCount++;
    [self updateScoreCard];
    self.scoreChangedCallBack(YES);

}
@end
