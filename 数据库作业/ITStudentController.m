//
//  ITStudentController.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/5/18.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITStudentController.h"

@interface ITStudentController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;
@end

@implementation ITStudentController
// MARK: - View's life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)logOut:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
