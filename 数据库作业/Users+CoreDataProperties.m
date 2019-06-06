//
//  Users+CoreDataProperties.m
//  数据库作业
//
//  Created by apple on 2019/6/6.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "Users+CoreDataProperties.h"

@implementation Users (CoreDataProperties)

+ (NSFetchRequest<Users *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Users"];
}

@dynamic password;
@dynamic userMode;
@dynamic userName;

@end
