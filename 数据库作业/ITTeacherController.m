//
//  ITTeacherController.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/5/18.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITTeacherController.h"
#import "AppDelegate.h"

@interface ITTeacherController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@end

@implementation ITTeacherController
// MARK: - View's life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// MARK: - Button events
- (IBAction)logout:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
