//
//  ITLoginController.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/5/18.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITLoginController.h"

@interface ITLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation ITLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
    [center addObserver:self selector:@selector(allHaveContents) name:UITextFieldTextDidChangeNotification object:self.userTextField];
    [center addObserver:self selector:@selector(allHaveContents) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
}
- (void)allHaveContents {
    self.loginButton.enabled = (![self.userTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]);
}
- (IBAction)loginIn:(UIButton *)sender {
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
@end
