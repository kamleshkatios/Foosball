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
                           @"Edit Score"];
    
    // Do any additional setup after loading the view.
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



@end
