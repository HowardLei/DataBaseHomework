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
// MARK: - Table view delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(ITTeacherInfoCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = self.teacherProperties[indexPath.row];
    cell.nameLabel.text = self.teacherDict[key];
    cell.valueLabel.text = [self.teacher valueForKey:key];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
