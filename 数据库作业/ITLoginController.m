//
//  ITLoginController.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/5/18.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITLoginController.h"
#import "ITTeacherController.h"
@interface ITLoginController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation ITLoginController
// MARK: - 视图的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
    [center addObserver:self selector:@selector(allHaveContents) name:UITextFieldTextDidChangeNotification object:self.userTextField];
    [center addObserver:self selector:@selector(allHaveContents) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
}
// MARK: - 管理按钮的事件
- (void)allHaveContents {
    self.loginButton.enabled = (![self.userTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]);
}
// MARK: - 管理文本框的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loginIn:self.loginButton];
    return YES;
}
// MARK: - 登录按钮
- (IBAction)loginIn:(UIButton *)sender {
    NSString *admin = @"admin";
    NSString *password = @"123456";
    if ([admin isEqualToString:self.userTextField.text] && [password isEqualToString:self.passwordTextField.text]) {
        // FIXME: 导航控制器与底边控制器逻辑还是混乱，不知道如何弄出来
        [self performSegueWithIdentifier:@"toTeacher" sender:nil];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toTeacher"]) {
        ITTeacherController *teacherController = segue.destinationViewController;
        teacherController.navigationItem.title = @"123";
    }
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
@end
