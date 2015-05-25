//
//  RankingViewController.m
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "RankingViewController.h"
#import "CoreDataHelper.h"
#import "RankingCell.h"
#import "Player.h"

@interface RankingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
@property (nonatomic, strong) NSArray *listOfPlayers;
@end

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *playersList = [[CoreDataHelper sharedCoreDataHelper] playersList];
    
    self.listOfPlayers = [playersList sortedArrayUsingComparator:^NSComparisonResult(Player* obj1, Player* obj2) {
        return [obj1.rank compare:obj2.rank];
    }];
    [self.baseTableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfPlayers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellId = @"RankingCell";
    RankingCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    cell.player = self.listOfPlayers[indexPath.row];
    return cell;
}

@end
