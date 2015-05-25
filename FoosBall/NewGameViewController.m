//
//  NewGameViewController.m
//  FoosBall
//
//  Created by kamlesh on 5/23/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "NewGameViewController.h"
#import "UIView+Resize.h"
#import "PickerView.h"
#import "CoreDataHelper.h"
#import "Player.h"
#import "GameViewController.h"

@interface NewGameViewController ()
@property (weak, nonatomic) IBOutlet UIButton *gamesCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *player1Btn;
@property (weak, nonatomic) IBOutlet UIButton *player2Btn;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;

@property (nonatomic) NSInteger noOfGames;
@property (nonatomic, strong) Player *player1;
@property (nonatomic, strong) Player *player2;

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
    PickerView *pickerView = [PickerView pickerView];
    [(UIButton *)sender addSubview:pickerView];
    
    __weak typeof (self) weakSelf = self;
    NSArray *list = @[@"3",@"5",@"7"];
    [pickerView showPickerWithItems:list selectedIndexCallback:^(NSInteger selectedIndex, BOOL isDone) {
        weakSelf.noOfGames = [list[selectedIndex] integerValue];
        [weakSelf.gamesCountBtn setTitle:[NSString stringWithFormat:@"No of Match : %@",list[selectedIndex]]
                                forState:UIControlStateNormal];
    }];
}

- (IBAction)player2BtnAction:(id)sender {
    NSArray *playersList = [[CoreDataHelper sharedCoreDataHelper] playersList];
    PickerView *pickerView = [PickerView pickerView];
    [(UIButton *)sender addSubview:pickerView];
    
    __weak typeof (self) weakSelf = self;
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:playersList.count];
    
    [playersList enumerateObjectsUsingBlock:^(Player* obj, NSUInteger idx, BOOL *stop) {
        [list addObject:[NSString stringWithFormat:@"%@ (%@)",obj.playerName, obj.playerId]];
    }];
    [pickerView showPickerWithItems:list selectedIndexCallback:^(NSInteger selectedIndex, BOOL isDone) {
        weakSelf.player2 = playersList[selectedIndex];
        [weakSelf.player2Btn setTitle:list[selectedIndex]
                             forState:UIControlStateNormal];
    }];
}

- (IBAction)player1BtnAction:(id)sender {
    
    NSArray *playersList = [[CoreDataHelper sharedCoreDataHelper] playersList];
    PickerView *pickerView = [PickerView pickerView];
    [(UIButton *)sender addSubview:pickerView];
    
    __weak typeof (self) weakSelf = self;
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:playersList.count];
    
    [playersList enumerateObjectsUsingBlock:^(Player* obj, NSUInteger idx, BOOL *stop) {
        [list addObject:[NSString stringWithFormat:@"%@ (%@)",obj.playerName, obj.playerId]];
    }];
    [pickerView showPickerWithItems:list selectedIndexCallback:^(NSInteger selectedIndex, BOOL isDone) {
        weakSelf.player1 = playersList[selectedIndex];
        [weakSelf.player1Btn setTitle:list[selectedIndex]
                                forState:UIControlStateNormal];
    }];
}

- (IBAction)continueAction:(id)sender {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:NSStringFromClass([GameViewController class])]) {
        GameViewController* gameViewController = [segue destinationViewController];
        gameViewController.noOfGames = self.noOfGames;
        gameViewController.player1 = self.player1;
        gameViewController.player2 = self.player2;
    }
}

@end
