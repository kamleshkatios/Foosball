//
//  AddMemberViewController.m
//  FoosBall
//
//  Created by kamlesh on 5/23/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "AddMemberViewController.h"
#import "UIView+Resize.h"
#import "CoreDataHelper.h"

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


- (IBAction)continueAction:(id)sender {
    
    if ([self.userNameTxt.text isEqualToString:@""]
        || [self.firstNameTxt.text isEqualToString:@""]
        || [self.lastName.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please complete all the fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    } else{
        NSDictionary *personDict = @{PlayerIdKey:self.userNameTxt.text,
                                     PlayerNameKey:[NSString stringWithFormat:@"%@ %@",self.firstNameTxt.text, self.lastName.text]};
        
        if ([[CoreDataHelper sharedCoreDataHelper] createPlayerObjectEntity:personDict]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have successfully added a member." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Duplicate" message:@"The User Name is already chosen, Please try with different user name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

@end
