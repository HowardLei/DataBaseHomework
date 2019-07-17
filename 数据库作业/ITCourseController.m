//
//  ITCourseController.m
//  数据库作业
//
//  Created by apple on 2019/6/14.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITCourseController.h"
#import "AppDelegate.h"
#import "Course+CoreDataClass.h"
#import "ITTeacherClassController.h"

@interface ITCourseController ()
@property (nonatomic, strong) UITextField *courseNameTextField;
@property (nonatomic, strong) UITextField *courseNoTextField;
@property (nonatomic, strong) UIBarButtonItem *addButton;
@property (nonatomic, strong) UIBarButtonItem *backButton;
@property (nonatomic, weak) AppDelegate *appDelegate;
@property (nonatomic, strong) ITTeacherClassController *teacherClassController;
@property (nonatomic, assign, getter=isOpen) BOOL open;
@end

@implementation ITCourseController
// MARK: - View's life cycle
- (instancetype)initWithClassController:(ITTeacherClassController *)controller {
    self = [super init];
    if (self) {
        self.teacherClassController = controller;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
    self.courseNameTextField.placeholder = @"请输入课程名";
    self.courseNoTextField.placeholder = @"请输入课程号";
    [self.view addSubview:self.courseNameTextField];
    [self.view addSubview:self.courseNoTextField];
    self.navigationItem.rightBarButtonItem = self.addButton;
    [center addObserver:self selector:@selector(waitDone) name:UITextFieldTextDidChangeNotification object:self.courseNoTextField];
    [center addObserver:self selector:@selector(waitDone) name:UITextFieldTextDidChangeNotification object:self.courseNameTextField];
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
// MARK: - Lazy loading data
- (UITextField *)courseNoTextField {
    if (_courseNoTextField == nil) {
        _courseNoTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 300, 30)];
        _courseNoTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _courseNoTextField;
}
- (UITextField *)courseNameTextField {
    if (_courseNameTextField == nil) {
        _courseNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 250, 300, 30)];
        _courseNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _courseNameTextField;
}
- (UIBarButtonItem *)addButton {
    if (_addButton == nil) {
        _addButton = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addCourse)];
    }
    return _addButton;
}
- (UIBarButtonItem *)backButton {
    if (_backButton == nil) {
        _backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    return _backButton;
}
- (AppDelegate *)appDelegate {
    if (_appDelegate == nil) {
        _appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    }
    return _appDelegate;
}
// MARK: - Button events
- (void)waitDone {
    self.addButton.enabled = (self.courseNoTextField.text.length && self.courseNameTextField.text.length);
}
- (void)addCourse {
    // 1. 设置添加对象
    Course *course = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(Course.class) inManagedObjectContext:self.appDelegate.managedObjectContext];
    course.cNo = self.courseNoTextField.text;
    course.cName = self.courseNameTextField.text;
    // 2. 保存到 Core data 当中
    NSError *saveError = nil;
    UIAlertController *alertController = nil;
    if ([self.appDelegate.managedObjectContext save:&saveError]) {
        alertController = [UIAlertController alertControllerWithTitle:@"添加成功" message:@"课程添加成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // FIXME: 当控制器被弹出以后没法刷新之前的控制器
            self.teacherClassController.refresh = YES;
            [self.navigationController popToViewController:self.teacherClassController animated:YES];
        }]];
        NSMutableSet<Course *> *courseSet = [NSMutableSet setWithSet:self.teacherClassController.teacher.courses];
        [courseSet addObject:course];
        self.teacherClassController.teacher.courses = courseSet;
    } else {
        alertController = [UIAlertController alertControllerWithTitle:@"添加失败" message:@"对不起，暂时无法添加" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self.courseNoTextField.text = nil;
            self.courseNameTextField.text = nil;
        }]];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
