//
//  GameViewController.h
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface GameViewController : UIViewController <UIAlertViewDelegate>
@property (nonatomic) NSInteger noOfGames;
@property (nonatomic, strong) Player *player1;
@property (nonatomic, strong) Player *player2;
@end
