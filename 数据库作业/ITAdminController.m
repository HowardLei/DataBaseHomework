//
//  ITAdminController.m
//  数据库作业
//
//  Created by apple on 2019/5/25.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITAdminController.h"
#import "AppDelegate.h"
#import "User+CoreDataClass.h"

@interface ITAdminController ()
@property (nonatomic, strong) NSArray<NSString *> *modes;
@property (nonatomic, strong) NSArray<User *> *admins;
@property (nonatomic, strong) NSArray<User *> *teachers;
@property (nonatomic, strong) NSArray<User *> *students;
@property (nonatomic, weak) AppDelegate *appDelegate;
@end

@implementation ITAdminController
// MARK: - View's life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initCoreData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
}
// MARK: - Button events
- (void)logOut {
    [self.navigationController popViewControllerAnimated:YES];
}
// MARK: - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modes.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 通过 KVO 来确定那个数组当中的元素，返回行数
    NSString *mode = self.modes[section];
    NSInteger rows = [[self valueForKey:[[mode lowercaseString] stringByAppendingString:@"s"]] count];
    return rows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const reuseIdentifier = @"adminCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *arrayName = [[self.modes[indexPath.section] lowercaseString] stringByAppendingString:@"s"];
    NSArray<User *> *array = [self valueForKey:arrayName];
    cell.textLabel.text = array[indexPath.row].userName;
    cell.detailTextLabel.text = array[indexPath.row].name;
    return cell;
}
// MARK: - Table view delegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.modes[section];
}
// MARK: - Lazy loading data
- (NSArray<NSString *> *)modes {
    if (_modes == nil) {
        _modes = @[@"Admin", @"Teacher", @"Student"];
    }
    return _modes;
}
- (AppDelegate *)appDelegate {
    if (_appDelegate == nil) {
        _appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    }
    return _appDelegate;
}
// MARK: Initialize core data
- (void)initCoreData {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(User.class) inManagedObjectContext:self.appDelegate.managedObjectContext];
    fetchRequest.entity = entity;
    NSError *error = nil;
    for (NSString *mode in self.modes) {
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userMode=%@", mode];
        [self setValue:[self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error] forKey:[[mode lowercaseString] stringByAppendingString:@"s"]];
    }
}
@end
