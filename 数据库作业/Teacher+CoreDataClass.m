//
//  Teacher+CoreDataClass.m
//  数据库作业
//
//  Created by apple on 2019/6/8.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "Teacher+CoreDataClass.h"

@implementation Teacher
- (NSString *)description
{
    return [NSString stringWithFormat:@"tName = %@, tNo = %@, courses = %@", self.tName, self.tNo, self.courses];
}
@end
