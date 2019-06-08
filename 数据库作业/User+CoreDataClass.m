//
//  User+CoreDataClass.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/6/7.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "User+CoreDataClass.h"

@implementation User
- (NSString *)description {
    return [NSString stringWithFormat:@"userName = %@, password = %@, userMode = %@, name = %@", self.userName, self.password, self.userMode, self.name];
}
@end
