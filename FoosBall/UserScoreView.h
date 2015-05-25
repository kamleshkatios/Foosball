//
//  UserScoreView.h
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

typedef void (^ScoreChangedCallBack)(BOOL didIncrement);

@interface UserScoreView : UIView
@property (nonatomic, strong) Player *player;
@property (nonatomic) NSInteger pointCount;
- (void)updateScoreCard;
- (void) setPlayer:(Player *)player andCallback:(ScoreChangedCallBack) scoreChangedCallBack;
@end
