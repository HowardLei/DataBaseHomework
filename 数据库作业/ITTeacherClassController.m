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
@interface ITTeacherClassController ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) AppDelegate *appDelegate;
@end

@implementation ITTeacherClassController
// MARK: - View's life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initCoreData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// MARK: - Lazy loading data
- (AppDelegate *)appDelegate {
    if (_appDelegate == nil) {
        _appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    }
    return _appDelegate;
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
    self.messageLabel.text = (!teachers.firstObject.courses.count) ? @"对不起，您还没添加课程，去添加一个课程吧。" : nil;
}
@end
