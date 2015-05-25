//
//  PickerView.h
//  FoosBall
//
//  Created by kamlesh on 5/24/15.
//  Copyright (c) 2015 kamlesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^SelectedIndexCallback)(NSInteger selectedIndex, BOOL isDone);

@interface PickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
+ (instancetype)pickerView;
- (void)showPickerWithItems:(NSArray *)items selectedIndexCallback:(SelectedIndexCallback)selectedIndexCallback;
@end
