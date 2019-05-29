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
@property(weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@end

@implementation ITTeacherController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// MARK: - 管理按钮事件
- (IBAction)logout:(UIBarButtonItem *)sender {
    NSLog(@"%s", __FUNCTION__);
    AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    appDelegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
}

@end
