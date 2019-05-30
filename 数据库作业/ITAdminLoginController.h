//
//  ITAdminLoginController.h
//  数据库作业
//
//  Created by 雷维卡 on 2019/5/30.
//  Copyright © 2019 ITCenter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ITAdminLoginController : UINavigationController

@end

@protocol ITAdminLoginControllerDelegate <NSObject>
- (void)canControllerPop;
@end

NS_ASSUME_NONNULL_END
