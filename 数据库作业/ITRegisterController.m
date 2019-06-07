//
//  ITRegisterController.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/5/18.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITRegisterController.h"
#import "ITAdminLoginController.h"
#import "User+CoreDataClass.h"
#import "AppDelegate.h"
@interface ITRegisterController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, ITAdminLoginControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *createUserTextField;
@property (weak, nonatomic) IBOutlet UITextField *createPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userModeView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *uploadButton;
@property (nonatomic, weak) AppDelegate *appDelegate;
@property (nonatomic, strong) NSArray<NSString *> *userArray;
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *modeDict;
typedef NS_ENUM(NSUInteger, ITUser) {
    ITUserStudent,
    ITUserTeacher
};

@end

@implementation ITRegisterController
NSString *const Student = @"Student";
NSString *const Teacher = @"Teacher";
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
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
// MARK: - Button events
- (void)canUploadNewData {
    // FIXME: 当选择添加用户的模式的时候不能触发通知。
    // 现在只能通过调整选择顺序来避开这个 Bug
    self.uploadButton.enabled = (self.createUserTextField.text.length > 0 && self.createPasswordTextField.text.length > 0 && self.againPasswordTextField.text.length > 0 && self.userModeView.text.length > 0);
}
- (IBAction)addDataToCoreData:(UIBarButtonItem *)sender {
    User *user = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(User.class) inManagedObjectContext:self.appDelegate.managedObjectContext];
    user.userName = self.createUserTextField.text;
    user.password = self.createPasswordTextField.text;
    user.userMode = self.modeDict[self.userModeView.text];
    NSError *saveError = nil;
    if ([self.appDelegate.managedObjectContext save:&saveError]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存完成" message:@"用户添加完成" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        NSLog(@"添加成功");
    } else {
        NSLog(@"保存失败:%@, %@", saveError, saveError.userInfo);
    }
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
- (AppDelegate *)appDelegate {
    if (_appDelegate == nil) {
        _appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    }
    return _appDelegate;
}
- (NSDictionary<NSString *,NSString *> *)modeDict {
    if (_modeDict == nil) {
        _modeDict = @{self.userArray[ITUserStudent]: Student, self.userArray[ITUserTeacher]: Teacher};
    }
    return _modeDict;
}
// MARK: - Admin login controller delegate
- (void)canControllerPop {
    if (self.createUserTextField.text.length | self.createPasswordTextField.text.length || self.againPasswordTextField.text.length || self.userModeView.text.length) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"里面还有未添加的内容" message:@"你还想保存这些数据吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"当然需要" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *abandonAction = [UIAlertAction actionWithTitle:@"对我来说已经没用了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }];
        [alertController addAction:saveAction];
        [alertController addAction:abandonAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
@end
