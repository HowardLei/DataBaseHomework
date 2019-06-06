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
#import "AppDelegate.h"
#import "Users+CoreDataClass.h"

@interface ITLoginController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic, weak) AppDelegate *appDelegate;
@end

@implementation ITLoginController
// MARK: - View's life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initAdmin];
}
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
// MARK: - Button events
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
    self.loginButton.enabled = (self.userTextField.text.length && self.passwordTextField.text.length);
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
// MARK: - Core Data initialize
- (void)initAdmin {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(Users.class) inManagedObjectContext:self.appDelegate.managedObjectContext];
    fetchRequest.entity = entity;
    NSError *error = nil;
    NSMutableArray *fetchedObjects = [[self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    // 检查数据管理员是否存在，如果不存在就添加。
    if (fetchedObjects == nil) {
        NSLog(@"错误信息：%@, %@", error, error.userInfo);
    }
}
// MARK: - Lazy loading properties
- (AppDelegate *)appDelegate {
    if (_appDelegate == nil) {
        _appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    }
    return _appDelegate;
}
@end
