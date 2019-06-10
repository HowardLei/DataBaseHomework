
//
//  ITStudentScoreController.m
//  数据库作业
//
//  Created by apple on 2019/6/8.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITStudentScoreController.h"
#import "ITStudentScoreCell.h"

@interface ITStudentScoreController ()

@end

@implementation ITStudentScoreController
// MARK: - View's life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
// MARK: - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (ITStudentScoreCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const reuseIdentifier = @"studentScoreCell";
    ITStudentScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell...
    return cell;
}
@end
