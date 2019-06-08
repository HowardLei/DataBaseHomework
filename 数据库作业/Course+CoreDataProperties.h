//
//  Course+CoreDataProperties.h
//  数据库作业
//
//  Created by apple on 2019/6/8.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "Course+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *cNo;
@property (nullable, nonatomic, copy) NSString *cName;
@property (nullable, nonatomic, retain) Teacher *teacher;
@property (nullable, nonatomic, retain) Student *student;

@end

NS_ASSUME_NONNULL_END
