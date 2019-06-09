//
//  ITTeacherWelcomeController.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/6/1.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITTeacherWelcomeController.h"
#import "AppDelegate.h"

@interface ITTeacherWelcomeController ()
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) AppDelegate *appDelegate;
@end

@implementation ITTeacherWelcomeController
// MARK: - View's life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.welcomeLabel.text = [NSString stringWithFormat:@"%@老师，欢迎回来", [self.appDelegate.name substringToIndex:1]];
}
- (AppDelegate *)appDelegate {
    if (_appDelegate == nil) {
        _appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    }
    return _appDelegate;
}
@end
