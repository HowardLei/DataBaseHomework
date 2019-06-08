//
//  SC+CoreDataProperties.m
//  数据库作业
//
//  Created by apple on 2019/6/8.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "SC+CoreDataProperties.h"

@implementation SC (CoreDataProperties)

+ (NSFetchRequest<SC *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SC"];
}

@dynamic sNo;
@dynamic cNo;
@dynamic grade;

@end
