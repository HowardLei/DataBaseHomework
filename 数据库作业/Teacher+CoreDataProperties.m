//
//  Teacher+CoreDataProperties.m
//  数据库作业
//
//  Created by apple on 2019/6/6.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "Teacher+CoreDataProperties.h"

@implementation Teacher (CoreDataProperties)

+ (NSFetchRequest<Teacher *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Teacher"];
}

@dynamic tName;
@dynamic tAge;
@dynamic courses;

@end
