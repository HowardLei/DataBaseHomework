//
//  ITCourseController.h
//  数据库作业
//
//  Created by apple on 2019/6/14.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Teacher;
NS_ASSUME_NONNULL_BEGIN

@interface ITCourseController : UIViewController
- (instancetype)initWithTeacher:(Teacher *)teacher;
@end

NS_ASSUME_NONNULL_END
