//
//  ITAdminLoginController.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/5/30.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITAdminLoginController.h"

@interface ITAdminLoginController () <UINavigationBarDelegate>

@end

@implementation ITAdminLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// MARK: - Navigation bar delegate
// 当需要控制导航器能否 push 与 pop 操作，需要实现 UINavigationBarDelegate 方法。
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    UIViewController *registerController = self.topViewController;
    // 注意：由于在判断弹出的方法并不是在当前控制器，所以需要先判断是否在该控制器当中有没有该判断方法，如果有再执行。
    if ([registerController respondsToSelector:@selector(canControllerPop)]) {
        [registerController performSelector:@selector(canControllerPop)];
    }
    // 在这个方法当中，由于在 registerController 当中调用 canControllerPop 方法里确定导航控制器什么时候弹出，所以这个地方就设置导航控制器不能点击按钮直接弹出。
    return NO;
}
@end
