//
//  GameViewController.m
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "GameViewController.h"
#import "UserScoreView.h"
#import "UIView+Resize.h"
#import "CoreDataHelper.h"

@interface GameViewController ()

@property (weak, nonatomic) IBOutlet UserScoreView *player1View;
@property (weak, nonatomic) IBOutlet UserScoreView *player2View;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchSegment;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (strong, nonatomic) NSArray *player1FirstConstrint;
@property (strong, nonatomic) NSArray *player2FirstConstrint;

- (IBAction)matchSegmentAction:(id)sender;
- (IBAction)finishBtnAction:(id)sender;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.finishBtn roundRectCorners];
    [self.player1View roundRectCorners];
    [self.player2View roundRectCorners];
    
    if (self.editMatch) {
        self.player1 = [[CoreDataHelper sharedCoreDataHelper] playerWithPlayerId:self.editMatch.player1Id];
        self.player2 = [[CoreDataHelper sharedCoreDataHelper] playerWithPlayerId:self.editMatch.player2Id];
    }
    __weak typeof(self) weakSelf = self;
    [self.player1View setPlayer:self.player1 andCallback:^(BOOL didIncrement) {
        [weakSelf arrangePlayers];
        if (didIncrement) {
            [weakSelf nextGame];
        }
    }];
    
    [self.player2View setPlayer:self.player2 andCallback:^(BOOL didIncrement){
        [weakSelf arrangePlayers];
        if (didIncrement) {
            [weakSelf nextGame];
        }
    }];
    
    if (self.editMatch) {
        self.player1View.pointCount = self.editMatch.player1Points.integerValue;
        self.player2View.pointCount = self.editMatch.player2Points.integerValue;
        [self.player1View updateScoreCard];
        [self.player2View updateScoreCard];
    }
    
    [self arrangePlayers];
    [self.player2View setBackgroundColor:[UIColor redColor]];
    
    [self.matchSegment removeAllSegments];
    for (int gameCount = 1; gameCount <= self.noOfGames; gameCount ++) {
        [self.matchSegment insertSegmentWithTitle:[NSString stringWithFormat:@"%d",gameCount]
                                          atIndex:gameCount-1 animated:NO];
    }
    self.matchSegment.selectedSegmentIndex = 0;
    // Do any additional setup after loading the view.
}

- (void) nextGame {
    if (self.matchSegment.selectedSegmentIndex == self.matchSegment.numberOfSegments -1) {
        [self gameFinish];
    }
    self.matchSegment.selectedSegmentIndex ++;
}
- (void) arrangePlayers {

    UIView *playerSuper = self.player2View.superview;
    playerSuper.translatesAutoresizingMaskIntoConstraints = NO;
    self.player1View.translatesAutoresizingMaskIntoConstraints = NO;
    self.player2View.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString *horizontalVisualConstraints = [NSString stringWithFormat:@"H:|-0-[player1View]-0-|"];
    [playerSuper addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalVisualConstraints options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil
                                                                          views:@{@"player1View":self.player1View}]];
    
    horizontalVisualConstraints = [NSString stringWithFormat:@"H:|-0-[player2View]-0-|"];
    [playerSuper addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalVisualConstraints options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil
                                                                          views:@{@"player2View":self.player2View}]];


    if (!self.player1FirstConstrint) {
        NSString *verticalVisualConstraints = [NSString stringWithFormat:@"V:|-10-[player1View]-10-[player2View]-10-|"];
        self.player1FirstConstrint = [NSLayoutConstraint constraintsWithVisualFormat:verticalVisualConstraints options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil
                                                                                   views:@{@"player2View":self.player2View,
                                                                                           @"player1View":self.player1View}];
    }
    if (!self.player2FirstConstrint) {
        NSString *verticalVisualConstraints = [NSString stringWithFormat:@"V:|-10-[player2View]-10-[player1View]-10-|"];
        self.player2FirstConstrint = [NSLayoutConstraint constraintsWithVisualFormat:verticalVisualConstraints options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil
                                                                                   views:@{@"player2View":self.player2View,
                                                                                           @"player1View":self.player1View}];
    }
    
    if (self.player1View.pointCount > self.player2View.pointCount
        || (self.player1View.pointCount == 0 && self.player2View.pointCount == 0)) {
        [playerSuper removeConstraints:self.player2FirstConstrint];
        [playerSuper addConstraints:self.player1FirstConstrint];
    } else if (self.player1View.pointCount < self.player2View.pointCount) {
        [playerSuper removeConstraints:self.player1FirstConstrint];
        [playerSuper addConstraints:self.player2FirstConstrint];
    }
    
    if (self.player1View.pointCount == self.player2View.pointCount) {
        return;
    }

    [playerSuper setNeedsUpdateConstraints];
    [UIView animateWithDuration:1.0 animations:^{
        [playerSuper layoutIfNeeded];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)matchSegmentAction:(id)sender {
}
- (IBAction)finishBtnAction:(id)sender {
    [self gameFinish];
    
    if (self.editMatch) {
        NSInteger player1Score = self.player1.matchWon.integerValue - self.editMatch.player1Points.integerValue;
        player1Score += self.player1View.pointCount;
        
        NSInteger player2Score = self.player2.matchWon.integerValue - self.editMatch.player2Points.integerValue;
        player2Score += self.player2View.pointCount;

        self.player1.matchWon = @(self.player1.matchWon.integerValue + player1Score);
        self.player2.matchWon = @(self.player2.matchWon.integerValue + player2Score);
    
        self.editMatch.player1Points = @(player1Score);
        self.editMatch.player2Points = @(player2Score);

        [[CoreDataHelper sharedCoreDataHelper] updatePlayerPoints:self.player1];
        [[CoreDataHelper sharedCoreDataHelper] updatePlayerPoints:self.player2];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void) gameFinish {
    if (self.editMatch) {
        return;
    }
    
    Player *winnerPlayer = nil;
    if (self.player1View.pointCount > self.player2View.pointCount) {
        winnerPlayer = self.player1;
    } else {
        winnerPlayer = self.player2;
    }
    
    self.player1.totalMatch = @([self.player1.totalMatch integerValue] + self.noOfGames);
    self.player2.totalMatch = @([self.player2.totalMatch integerValue] + self.noOfGames);
    
    self.player1.matchWon = @(self.player1.matchWon.integerValue + self.player1View.pointCount);
    self.player2.matchWon = @(self.player2.matchWon.integerValue + self.player2View.pointCount);
    
    [[CoreDataHelper sharedCoreDataHelper] updatePlayerPoints:self.player1];
    [[CoreDataHelper sharedCoreDataHelper] updatePlayerPoints:self.player2];
    
    NSDictionary *matchInfo = @{NumberOfGamesKey:@(self.noOfGames),
                            Player1IdKey:self.player1.playerId,
                            Player2IdKey:self.player2.playerId,
                            Player1PointsKey:@(self.player1View.pointCount),
                            Player2PointsKey:@(self.player2View.pointCount),
                            MatchDateKey:[NSDate date]
                            };    
    [[CoreDataHelper sharedCoreDataHelper] createMatchObjectEntity:matchInfo];
    
    NSString *message = [NSString stringWithFormat:@"%@ has won the match", winnerPlayer.playerName];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Congratulation!"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
