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
#import "User+CoreDataClass.h"

@interface ITLoginController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UISwitch *rememberPassword;
@property (nonatomic, weak) AppDelegate *appDelegate;
@end

@implementation ITLoginController
static BOOL hasOtherUsers = NO;
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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(User.class) inManagedObjectContext:self.appDelegate.managedObjectContext];
    fetchRequest.entity = entity;
    NSPredicate *restrictCondition = [NSPredicate predicateWithFormat:@"userName=%@ and password=%@", self.userTextField.text, self.passwordTextField.text];
    fetchRequest.predicate = restrictCondition;
    NSError *error = nil;
    NSArray<User *> *users = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (users.count != 1) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"请检查一下输入的账号和密码" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"去检查" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.passwordTextField.text = nil;
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    } else {
        // 将当前控制器的值传给 ITTeacherController 的 viewController 属性当中
        if (!self.rememberPassword.isOn) {
            self.passwordTextField.text = nil;
        }
        [self performSegueWithIdentifier:@"toAdmin" sender:self];
    }
    if (users == nil) {
        NSLog(@"数据错误");
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
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(User.class)];
    NSError *searchError = nil;
    NSMutableArray<User *> *users = [[self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&searchError] mutableCopy];
    if (!users && !searchError) {
        NSLog(@"错误信息：%@, %@", searchError, searchError.userInfo);
    }
    if (!hasOtherUsers) {
        while (users.count > 1) {
            [self.appDelegate.managedObjectContext deleteObject:users.firstObject];
            users = [[self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&searchError] mutableCopy];
        }
        hasOtherUsers = YES;
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
