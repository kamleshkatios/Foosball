//
//  AddMemberViewController.m
//  FoosBall
//
//  Created by kamlesh on 5/23/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "AddMemberViewController.h"
#import "UIView+Resize.h"

@interface AddMemberViewController ()
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
- (IBAction)continueAction:(id)sender;
- (IBAction)addMoreAction:(id)sender;
@end

@implementation AddMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.continueBtn roundRectCorners];
    [self.cancelBtn roundRectCorners];
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

- (IBAction)continueAction:(id)sender {
}

- (IBAction)addMoreAction:(id)sender {
}
@end
