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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *uploadButton;
@end

@implementation ITRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
    [center addObserver:self selector:@selector(canUploadNewData) name:UITextFieldTextDidChangeNotification object:self.createUserTextField];
    [center addObserver:self selector:@selector(canUploadNewData) name:UITextFieldTextDidChangeNotification object:self.createPasswordTextField];
    [center addObserver:self selector:@selector(canUploadNewData) name:UITextFieldTextDidChangeNotification object:self.againPasswordTextField];
    [center addObserver:self selector:@selector(canUploadNewData) name:UITextFieldTextDidChangeNotification object:self.userModeView];
}
- (void)canUploadNewData {
    // FIXME: 这个地方没法判断 userModeView 的成功添加的条件
    self.uploadButton.enabled = (![self.createUserTextField.text isEqualToString:@""] && ![self.createPasswordTextField.text isEqualToString:@""] && ![self.againPasswordTextField.text isEqualToString:@""]);
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
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
@end
