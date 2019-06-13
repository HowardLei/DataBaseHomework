//
//  ITTeacherClassController.m
//  数据库作业
//
//  Created by apple on 2019/6/11.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITTeacherClassController.h"
#import "AppDelegate.h"
#import "Teacher+CoreDataClass.h"
#import "Course+CoreDataClass.h"

@interface ITTeacherClassController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) AppDelegate *appDelegate;
@property (nonatomic, strong) Teacher *teacher;
@property (nonatomic, strong) NSArray<Course *> *courses;
@end

@implementation ITTeacherClassController
static NSString *const reuseIdentifier = @"cell";
// MARK: - View's life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initCoreData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 先判断里面有没有内容，如果有课程则加载 TableView，否则加载 Label，提示没有任何课程。
    UILabel *label = nil;
    UITableView *tableView = nil;
    if (!self.teacher.courses.count) {
        label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.text = @"对不起，您还没添加课程，去添加一个课程吧。";
        label.textColor = [UIColor lightGrayColor];
        NSLayoutConstraint *labelCons1 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterXWithinMargins relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterXWithinMargins multiplier:1 constant:0];
        NSLayoutConstraint *labelCons2 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterYWithinMargins relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterYWithinMargins multiplier:1 constant:0];
        [self.view addSubview:label];
        [NSLayoutConstraint activateConstraints:@[labelCons1, labelCons2]];
    } else {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 35) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:reuseIdentifier];
        [self.view addSubview:tableView];
    }
}
// MARK: - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}
// MARK: - Table view delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    cell.textLabel.text = self.courses[indexPath.row].cName;
}
// MARK: Button events
- (IBAction)manageClass:(UIBarButtonItem *)sender {
    if (self.view.subviews.count == 1 && [self.view.subviews.firstObject isMemberOfClass:UILabel.class]) {
        // 加载一个新控制器，设置里面的添加班级。
        UIViewController *viewController = [[UIViewController alloc] init];
    }
}
// MARK: - Lazy loading data
- (AppDelegate *)appDelegate {
    if (_appDelegate == nil) {
        _appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    }
    return _appDelegate;
}
// MARK: - Initialize core data
// FIXME: 不知道老师如何在课程当中添加学生
- (void)initCoreData {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(Teacher.class) inManagedObjectContext:self.appDelegate.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"tName=%@", self.appDelegate.name];
    NSError *searchError = nil;
    NSArray<Teacher *> *teachers = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&searchError];
    if (teachers == nil) {
        @throw [NSException exceptionWithName:@"老师查找失败" reason:@"没有寻找到该老师" userInfo:nil];
    }
    self.teacher = teachers.firstObject;
    self.courses = self.teacher.courses.allObjects;
}
@end
