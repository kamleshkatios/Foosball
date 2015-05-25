//
//  PickerView.m
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import "PickerView.h"
#import "Utilities.h"

@interface PickerView ()
@property (nonatomic, strong) NSArray *itemsList;
@property (nonatomic, strong) UIPickerView *picker;
@property (copy, nonatomic) SelectedIndexCallback selectedIndexCallback;
@property (nonatomic, strong) UITextField *hiddenTextField;
@end

@implementation PickerView

+ (instancetype)pickerView {
    PickerView *pickerView = [[PickerView alloc] initWithFrame:CGRectZero];
    pickerView.hiddenTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [pickerView addSubview:pickerView.hiddenTextField];
    return pickerView;
}

- (void)addDismissToolbar:(id)object {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [Utilities screenWidth], 44.0)];
    [toolbar setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *dismissButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissFieldInput:)];
    toolbar.barStyle = UIBarStyleDefault;
    toolbar.translucent = YES;
    [toolbar setItems:@[space,dismissButton]];
    [object setInputAccessoryView:toolbar];
}

- (UIPickerView *)addPickerToTextFieldDelegate:(id <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>)delegate {
    
    // Sets up the picker (same tag as the textfield)
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    picker.showsSelectionIndicator = YES;
    picker.delegate = delegate;
    picker.dataSource = delegate;
    [self.hiddenTextField setInputView:picker];
    
    // Adds a dismiss toolbar, since all fields with pickers should have one.
    [self addDismissToolbar:self.hiddenTextField];
    
    return picker;
}

- (void)dismissFieldInput:(id)sender {
    if (self.selectedIndexCallback) {
        self.selectedIndexCallback([self.picker selectedRowInComponent:0], YES);
    }
    [self.hiddenTextField resignFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (void)showPickerWithItems:(NSArray *)items selectedIndexCallback:(SelectedIndexCallback)selectedIndexCallback {
    self.picker = [self addPickerToTextFieldDelegate:self];
    self.itemsList = items;
    self.selectedIndexCallback = selectedIndexCallback;
    [self.hiddenTextField becomeFirstResponder];
}
#pragma mark -
#pragma mark UIPicker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.itemsList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.itemsList[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.selectedIndexCallback) {
        self.selectedIndexCallback([self.picker selectedRowInComponent:0], NO);
    }
}


@end
