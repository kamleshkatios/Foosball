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

@interface GameViewController ()

@property (weak, nonatomic) IBOutlet UserScoreView *player1View;
@property (weak, nonatomic) IBOutlet UserScoreView *player2View;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchSegment;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (nonatomic) NSInteger temp;

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
    
    [self arrangePlayers];
    [self.player2View setBackgroundColor:[UIColor redColor]];
    // Do any additional setup after loading the view.
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

    if (self.temp % 2 == 0) {
        [playerSuper removeConstraints:self.player2FirstConstrint];
        [playerSuper addConstraints:self.player1FirstConstrint];
    } else {
        [playerSuper removeConstraints:self.player1FirstConstrint];
        [playerSuper addConstraints:self.player2FirstConstrint];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)matchSegmentAction:(id)sender {
}
- (IBAction)finishBtnAction:(id)sender {
    self.temp++;
    [self arrangePlayers];
}
@end
