//
//  ITRegisterController.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/5/18.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITRegisterController.h"
#import "ITLoginController.h"
@interface ITRegisterController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *createUserTextField;
@property (weak, nonatomic) IBOutlet UITextField *createPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userModeView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *uploadButton;
@property (nonatomic, strong) NSArray<NSString *> *userArray;
typedef NS_ENUM(NSUInteger, ITUser) {
    ITUserStudent,
    ITUserTeacher
};
@end

@implementation ITRegisterController
// MARK: - View's life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
    [center addObserver:self selector:@selector(canUploadNewData) name:UITextFieldTextDidChangeNotification object:self.createUserTextField];
    [center addObserver:self selector:@selector(canUploadNewData) name:UITextFieldTextDidChangeNotification object:self.createPasswordTextField];
    [center addObserver:self selector:@selector(canUploadNewData) name:UITextFieldTextDidChangeNotification object:self.againPasswordTextField];
    [center addObserver:self selector:@selector(canUploadNewData) name:UITextFieldTextDidChangeNotification object:self.userModeView];
}
// 当点击返回的时候，通过这个方法进行方法回调
// FIXME: 在视图即将消失的时候，if 当中的代码块能够执行，但是没有任何效果出现。
// @Reason: 当点击返回按钮的时候，该控制器已经离开了应用程序代理窗口控制的层级了，只不过他里面的 view 还没有被移除。
// 解决方案：需要在控制器还在应用程序代理窗口的控制层级的时候进行数据检测，看是否需要保存数据。
// https://www.jianshu.com/p/90a104ac6633
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.createUserTextField.text.length || self.createPasswordTextField.text.length || self.againPasswordTextField.text.length || self.userModeView.text.length) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"里面还有未添加的内容" message:@"你还想保存这些数据吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"当然需要" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *abandonAction = [UIAlertAction actionWithTitle:@"对我来说已经没用了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:saveAction];
        [alertController addAction:abandonAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
// MARK: - Button event
- (void)canUploadNewData {
    self.uploadButton.enabled = (![self.createUserTextField.text isEqualToString:@""] && ![self.createPasswordTextField.text isEqualToString:@""] && ![self.againPasswordTextField.text isEqualToString:@""] && [self.userModeView.text isEqualToString:@""]);
}
// MARK: - Text field delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UIPickerView *userPickerView = [[UIPickerView alloc] init];
    userPickerView.dataSource = self;
    userPickerView.delegate = self;
    textField.text = [self pickerView:userPickerView titleForRow:0 forComponent:0];
    textField.inputView = userPickerView;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toBeString.length > 2) {
        textField.text = [toBeString substringToIndex:2];
        return NO;
    }
    return YES;
}
// MARK: - Picker view data source
- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}
// MARK: - Picker view delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.userArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.userModeView.text = [self pickerView:pickerView titleForRow:row forComponent:component];
}
// MARK: - Paste board event
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}
// MARK: - Lazy loading datas
- (NSArray<NSString *> *)userArray {
    if (_userArray == nil) {
        _userArray = @[@"学生", @"老师"];
    }
    return _userArray;
}
@end
