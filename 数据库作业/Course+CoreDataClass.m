//
//  Course+CoreDataClass.m
//  数据库作业
//
//  Created by apple on 2019/6/8.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "Course+CoreDataClass.h"

@implementation Course
- (NSString *)description {
    return [NSString stringWithFormat:@"cNo = %@, cName = %@, teacher = %@, student = %@", self.cNo, self.cName, self.teacher, self.student];
}
@end
