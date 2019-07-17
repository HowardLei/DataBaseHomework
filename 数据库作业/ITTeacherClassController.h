//
//  ITTeacherClassController.h
//  数据库作业
//
//  Created by apple on 2019/6/11.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Teacher+CoreDataClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITTeacherClassController : UIViewController
@property (nonatomic, strong) Teacher *teacher;
@property (nonatomic, assign, getter=needRefresh) BOOL refresh;
@end

NS_ASSUME_NONNULL_END
