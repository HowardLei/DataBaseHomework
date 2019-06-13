//
//  ITTeacherInfoController.m
//  数据库作业
//
//  Created by apple on 2019/6/11.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITTeacherInfoController.h"
#import "AppDelegate.h"
#import "Teacher+CoreDataClass.h"
#import "ITTeacherInfoCell.h"

@interface ITTeacherInfoController ()
@property (nonatomic, weak) AppDelegate *appDelegate;
@property (nonatomic, strong) Teacher *teacher;
@property (nullable, nonatomic, strong) NSDictionary<NSString *, NSString *> *teacherDict;
@property (nonatomic, strong) NSArray<NSString *> *teacherProperties;
@end

@implementation ITTeacherInfoController
// MARK: - View's life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initCoreData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// MARK: - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teacherProperties.count;
}
- (ITTeacherInfoCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const reuseIdentifier = @"teacherInfoCell";
    ITTeacherInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// MARK: - Table view delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(ITTeacherInfoCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = self.teacherProperties[indexPath.row];
    cell.nameLabel.text = self.teacherDict[key];
    cell.valueLabel.text = [self.teacher valueForKey:key];
}
// FIXME: 修改功能暂时无法上线。数据无法正确修改，而且不能点击完编辑再修改
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"编辑" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *editAction = [UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(Teacher.class)];
        NSError *error = nil;
        Teacher *teacher = [self.appDelegate.managedObjectContext executeFetchRequest:request error:&error].firstObject;
        // 点击编辑按钮，执行大括号里面的逻辑。
        UITextField *textField = alertController.textFields.firstObject;
        // 1. 将新值修改到数据库当中
        [teacher setValue:textField.text forKey:self.teacherProperties[indexPath.row]];
        if (![self.appDelegate.managedObjectContext save:&error]) {
            NSLog(@"修改失败 %@: %@", error, error.userInfo);
        }
        [self.tableView reloadData];
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        NSString *model = [self.teacher valueForKey:self.teacherProperties[indexPath.row]];
        textField.text = model;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    [alertController addAction:editAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
// MARK: - Button events
- (IBAction)editCell:(UIBarButtonItem *)sender {
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    sender.title = self.tableView.isEditing ? @"完成": @"编辑";
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
// MARK: - Lazy loading data
- (AppDelegate *)appDelegate {
    if (_appDelegate == nil) {
        _appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    }
    return _appDelegate;
}
- (NSArray<NSString *> *)teacherProperties {
    if (_teacherProperties == nil) {
        _teacherProperties = @[@"tName", @"tNo"];
    }
    return _teacherProperties;
}
- (NSDictionary<NSString *, NSString *> *)teacherDict {
    if (_teacherDict == nil) {
        _teacherDict = @{@"tName": @"姓名", @"tNo": @"教职工号"};
    }
    return _teacherDict;
}
// MARK: - Initialize core data
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
}
@end
