//
//  ITAdminController.m
//  数据库作业
//
//  Created by apple on 2019/5/25.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITAdminController.h"

@interface ITAdminController ()

@end

@implementation ITAdminController
// MARK: - View's life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
}
- (void)logOut {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
