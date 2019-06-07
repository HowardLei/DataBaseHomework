//
//  ITTeacherWelcomeController.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/6/1.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import "ITTeacherWelcomeController.h"

@interface ITTeacherWelcomeController ()
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
// 记录时间的数组
@property (nonatomic, strong) NSArray<NSString *> *timeSeperations;
@end

@implementation ITTeacherWelcomeController
// MARK: - View's life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// MARK: - Widget data center
/**
 设置 welcomeLabel 的显示内容，他会随着时间的变化动态变化。
 @param welcomeLabel 欢迎 label
 */
- (void)setWelcomeLabel:(UILabel *)welcomeLabel {
    _welcomeLabel = welcomeLabel;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    int hour = time.intValue;
    // 根据时间判断选择数组当中的第几个选项。 
}
// MARK: - Lazy loading datas
- (NSArray<NSString *> *)timeSeperations {
    if (_timeSeperations == nil) {
        _timeSeperations = @[@"清晨", @"上午", @"中午", @"下午", @"傍晚", @"晚上", @"深夜"];
    }
    return _timeSeperations;
}
@end
