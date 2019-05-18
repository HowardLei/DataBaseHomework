//
//  ITRegisterController.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/5/18.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITRegisterController.h"

@interface ITRegisterController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *createUserTextField;
@property (weak, nonatomic) IBOutlet UITextField *createPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userModeView;

@end

@implementation ITRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
// 当点击返回的时候，通过这个方法进行方法回调
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

@end
