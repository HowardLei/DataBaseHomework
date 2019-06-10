//
//  Student+CoreDataClass.m
//  数据库作业
//
//  Created by apple on 2019/6/8.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "Student+CoreDataClass.h"

@implementation Student
- (NSString *)description
{
    return [NSString stringWithFormat:@"sNo = %@, sName = %@, sDept = %@, course = %@", self.sNo, self.sName, self.sDept, self.courses];
}
@end
