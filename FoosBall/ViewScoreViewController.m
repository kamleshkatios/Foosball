//
//  ViewScoreViewController.m
//  FoosBall
//
//  Created by kamlesh on 5/25/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "ViewScoreViewController.h"
#import "CoreDataHelper.h"
#import "ScoreViewCell.h"
#import "GameViewController.h"

@interface ViewScoreViewController ()
@property (nonatomic, weak) IBOutlet UITableView *baseTableView;
@property (nonatomic, strong) NSArray *listOfMatch;
@property (nonatomic, strong) NSIndexPath *selectedIndex;
@end

@implementation ViewScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listOfMatch = [[CoreDataHelper sharedCoreDataHelper] matchList];
    
    [self.baseTableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:NSStringFromClass([GameViewController class])]) {
        GameViewController* gameViewController = [segue destinationViewController];
        gameViewController.editMatch = self.listOfMatch[self.selectedIndex.row];
    }
}

#pragma mark -
#pragma mark Tableview

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfMatch.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellId = @"ScoreViewCell";
    ScoreViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    cell.match = self.listOfMatch[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath;
}

@end
