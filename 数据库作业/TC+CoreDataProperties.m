//
//  TC+CoreDataProperties.m
//  数据库作业
//
//  Created by apple on 2019/6/11.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "TC+CoreDataProperties.h"

@implementation TC (CoreDataProperties)

+ (NSFetchRequest<TC *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"TC"];
}

@dynamic cNo;
@dynamic tNo;

@end
