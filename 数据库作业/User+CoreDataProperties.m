//
//  User+CoreDataProperties.m
//  数据库作业
//
//  Created by 雷维卡 on 2019/6/7.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"User"];
}

@dynamic userName;
@dynamic password;
@dynamic userMode;

@end
