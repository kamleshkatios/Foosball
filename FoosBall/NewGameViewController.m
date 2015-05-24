//
//  NewGameViewController.m
//  FoosBall
//
//  Created by kamlesh on 5/23/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "NewGameViewController.h"
#import "UIView+Resize.h"

@interface NewGameViewController ()
@property (weak, nonatomic) IBOutlet UIButton *gamesCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *player1Btn;
@property (weak, nonatomic) IBOutlet UIButton *player2Btn;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;

- (IBAction)gamesCountAction:(id)sender;
- (IBAction)player2BtnAction:(id)sender;
- (IBAction)player1BtnAction:(id)sender;
- (IBAction)continueAction:(id)sender;
@end

@implementation NewGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.gamesCountBtn roundedCornersWithBorder];
    [self.player1Btn roundedCornersWithBorder];
    [self.player2Btn roundedCornersWithBorder];
    [self.continueBtn roundRectCorners];
    
    // Do any additional setup after loading the view.
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

- (IBAction)gamesCountAction:(id)sender {
}

- (IBAction)player2BtnAction:(id)sender {
}

- (IBAction)player1BtnAction:(id)sender {
}

- (IBAction)continueAction:(id)sender {
}
@end
