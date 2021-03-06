
//
//  ITStudentScoreController.m
//  数据库作业
//
//  Created by apple on 2019/6/8.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITStudentScoreController.h"
#import "ITStudentScoreCell.h"
#import "AppDelegate.h"
#import "Course+CoreDataClass.h"
#import "Student+CoreDataClass.h"

@interface ITStudentScoreController ()
@property (nonatomic, weak) AppDelegate *appDelegate;
@property (nonatomic, strong) NSArray<Course *> *courses;
@end

@implementation ITStudentScoreController
// MARK: - View's life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initCoreData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
// MARK: - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}
- (ITStudentScoreCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const reuseIdentifier = @"studentScoreCell";
    ITStudentScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell...
    return cell;
}
// MARK: - Table view delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(ITStudentScoreCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.courseLabel.text = self.courses[indexPath.row].cName;
    cell.scoreLabel.text = nil;
}
// MARK: - Lazy loading datas
- (AppDelegate *)appDelegate {
    if (_appDelegate == nil) {
        _appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    }
    return _appDelegate;
}
// MARK: - Core Data initialize
// FIXME: 查询逻辑还是没理清楚
- (void)initCoreData {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(Student.class) inManagedObjectContext:self.appDelegate.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"sName=%@", self.appDelegate.name];
    NSError *searchError = nil;
    NSArray<Student *> *results = nil;
    @try {
        results = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&searchError];
    } @catch (NSException *exception) {
        NSLog(@"对不起，查找失败，请看看是不是实体或者是限制条件设置错误");
        abort();
    }
}
@end
