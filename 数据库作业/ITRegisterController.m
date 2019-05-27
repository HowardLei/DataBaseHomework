//
//  ITRegisterController.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/5/18.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITRegisterController.h"

@interface ITRegisterController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *createUserTextField;
@property (weak, nonatomic) IBOutlet UITextField *createPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userModeView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *uploadButton;
typedef NS_ENUM(NSUInteger, ITUser) {
    ITUserStudent,
    ITUserTeacher
};
@end

@implementation ITRegisterController
// MARK: - View 的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
    [center addObserver:self selector:@selector(canUploadNewData) name:UITextFieldTextDidChangeNotification object:self.createUserTextField];
    [center addObserver:self selector:@selector(canUploadNewData) name:UITextFieldTextDidChangeNotification object:self.createPasswordTextField];
    [center addObserver:self selector:@selector(canUploadNewData) name:UITextFieldTextDidChangeNotification object:self.againPasswordTextField];
    [center addObserver:self selector:@selector(canUploadNewData) name:UITextFieldTextDidChangeNotification object:self.userModeView];
    UIPickerView *userPickerView = [[UIPickerView alloc] init];
    userPickerView.dataSource = self;
    userPickerView.delegate = self;
    self.userModeView.inputView = userPickerView;
}
// 当点击返回的时候，通过这个方法进行方法回调
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
// MARK: - 管理按钮的事件
- (void)canUploadNewData {
    self.uploadButton.enabled = (![self.createUserTextField.text isEqualToString:@""] && ![self.createPasswordTextField.text isEqualToString:@""] && ![self.againPasswordTextField.text isEqualToString:@""]) && [self.userModeView.text isEqualToString:@""];
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
    switch (row) {
        case ITUserStudent:
            return @"学生";
        case ITUserTeacher:
            return @"老师";
    }
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.userModeView.text = [self pickerView:pickerView titleForRow:row forComponent:component];
}
@end
