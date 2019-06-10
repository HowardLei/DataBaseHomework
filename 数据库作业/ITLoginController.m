//
//  ITLoginController.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/5/18.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "AppDelegate.h"
#import "ITLoginController.h"
#import "ITStudentController.h"
#import "ITTeacherController.h"
#import "ITAdminController.h"
#import "User+CoreDataClass.h"
#import "Teacher+CoreDataClass.h"
#import "Student+CoreDataClass.h"

@interface ITLoginController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UISwitch *rememberPassword;
@property (nonatomic, weak) AppDelegate *appDelegate;
@end

@implementation ITLoginController
// MARK: - View's life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initCoreData];
    if (!self.rememberPassword.isOn) {
        self.userTextField.text = nil;
    }
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
        // 这步是为了让登录成功以后可以将姓氏显示在 welcomeLabel 当中
        self.appDelegate.name = users.firstObject.name;
        NSString *userMode = users.firstObject.userMode;
        if ([userMode isEqualToString:@"Admin"]) {
            ITAdminController *adminController = [self.storyboard instantiateViewControllerWithIdentifier:@"adminController"];
            [self.navigationController pushViewController:adminController animated:YES];
        } else if ([userMode isEqualToString:@"Student"]) {
            ITStudentController *studentController = [self.storyboard instantiateViewControllerWithIdentifier:@"studentController"];
            [self.navigationController pushViewController:studentController animated:YES];
        } else {
            ITTeacherController *teacherController = [self.storyboard instantiateViewControllerWithIdentifier:@"teacherController"];
            [self.navigationController pushViewController:teacherController animated:YES];
        }
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
// MARK: - Core Data initialize
- (void)initCoreData {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(User.class)];
    NSError *searchError = nil;
    NSMutableArray<User *> *users = [[self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&searchError] mutableCopy];
    if (!users && !searchError) {
        NSLog(@"错误信息：%@, %@", searchError, searchError.userInfo);
    }
    if (users.count < 1) {
        // 创建 3 个成员
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            // 创建管理员
            User *adminUser = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(User.class) inManagedObjectContext:self.appDelegate.managedObjectContext];
            adminUser.userName = @"admin";
            adminUser.password = @"123456";
            adminUser.userMode = @"Admin";
            adminUser.name = @"管理员";
            // 创建学生
            User *teacherUser = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(User.class) inManagedObjectContext:self.appDelegate.managedObjectContext];
            teacherUser.userName = @"xiaoming";
            teacherUser.userMode = @"Teacher";
            teacherUser.password = @"aaa";
            teacherUser.name = @"明天";
            Teacher *teacher = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(Teacher.class) inManagedObjectContext:self.appDelegate.managedObjectContext];
            teacher.tNo = [NSString stringWithFormat:@"%d", arc4random()];
            teacher.tName = teacherUser.name;
            teacher.courses = nil;
            // 创建学生
            User *studentUser = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(User.class) inManagedObjectContext:self.appDelegate.managedObjectContext];
            studentUser.userMode = @"Student";
            studentUser.userName = @"wangnima";
            studentUser.password = @"123";
            studentUser.name = @"王涛";
            Student *student = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(Student.class) inManagedObjectContext:self.appDelegate.managedObjectContext];
            student.sName = studentUser.name;
            student.sNo = [NSString stringWithFormat:@"%d", arc4random()];
            student.courses = nil;
            student.sDept = @"CS";
            NSError *saveError = nil;
            if ([self.appDelegate.managedObjectContext save:&saveError]) {
                NSLog(@"成功");
            } else {
                NSLog(@"添加失败");
            }
        });
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
