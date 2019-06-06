//
//  Student+CoreDataProperties.m
//  数据库作业
//
//  Created by apple on 2019/6/6.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic sName;
@dynamic sNo;
@dynamic sAge;
@dynamic sDept;
@dynamic courses;

@end
