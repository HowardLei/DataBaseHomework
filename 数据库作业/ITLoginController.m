//
//  ITLoginController.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/5/18.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITLoginController.h"
#import "ITAdminController.h"
#import "ITTeacherController.h"

@interface ITLoginController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation ITLoginController
// MARK: - View's life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
    [center addObserver:self selector:@selector(allHaveContents) name:UITextFieldTextDidChangeNotification object:self.userTextField];
    [center addObserver:self selector:@selector(allHaveContents) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
// MARK: - Button event
- (IBAction)loginIn:(UIButton *)sender {
    NSString *admin = @"admin";
    NSString *password = @"123456";
    if ([admin isEqualToString:self.userTextField.text] && [password isEqualToString:self.passwordTextField.text]) {
        // 将当前控制器的值传给 ITTeacherController 的 viewController 属性当中
        [self performSegueWithIdentifier:@"toAdmin" sender:self];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"请检查一下输入的账号和密码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"去检查" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:confirmAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
// 监听按钮通知当中的方法
- (void)allHaveContents {
    self.loginButton.enabled = (![self.userTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]);
}
// MARK: - Text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loginIn:self.loginButton];
    return YES;
}
// MARK: - Segue operations
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toAdmin"]) {
        ITAdminController *adminController = segue.destinationViewController;
        ITTeacherController *teacherController = (ITTeacherController *) adminController.topViewController;
        teacherController.viewController = self;
    }
}

@end
