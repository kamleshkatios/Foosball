//
//  MainViewController.m
//  FoosBall
//
//  Created by kamlesh on 5/20/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "MainViewController.h"
#import "WelcomeHeader.h"
#import "UIColor+Extra.h"
#import "AddMemberViewController.h"
#import "NewGameViewController.h"
#import "CoreDataHelper.h"
#import "RankingViewController.h"
#import "ViewScoreViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *baseTableview;
@property (strong, nonatomic) NSArray *listOfOptions;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.listOfOptions = @[@"Start A Game",
                           @"Add A New Player",
                           @"View Score",
                           @"Edit Score",
                           @"View Ranking"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellId = @"WelcomeCell";
    UITableViewCell* cell = [self.baseTableview dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    cell.textLabel.text = self.listOfOptions[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WelcomeHeader *welcomeHeader = [WelcomeHeader loadFromNib];
    return welcomeHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * storyboardName = @"Main";
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    
    NSString * viewControllerID = @"EventsTab";

    if (indexPath.row == 0) {
        if ([[CoreDataHelper sharedCoreDataHelper] playersList].count < 2) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"There is no enough players to start the match."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        viewControllerID = NSStringFromClass([NewGameViewController class]);
    } else if (indexPath.row == 1) {
        viewControllerID = NSStringFromClass([AddMemberViewController class]);
    } else if (indexPath.row == 2) {
        viewControllerID = NSStringFromClass([ViewScoreViewController class]);
    } else if (indexPath.row == 3) {
        viewControllerID = NSStringFromClass([ViewScoreViewController class]);
    } else if (indexPath.row == 4) {
        viewControllerID = NSStringFromClass([RankingViewController class]);
    }
    UIViewController * viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
