//
//  Student+CoreDataProperties.h
//  数据库作业
//
//  Created by apple on 2019/6/6.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *sName;
@property (nullable, nonatomic, copy) NSString *sNo;
@property (nonatomic) int32_t sAge;
@property (nullable, nonatomic, copy) NSString *sDept;
@property (nullable, nonatomic, retain) NSSet<Student *> *courses;

@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(Student *)value;
- (void)removeCoursesObject:(Student *)value;
- (void)addCourses:(NSSet<Student *> *)values;
- (void)removeCourses:(NSSet<Student *> *)values;

@end

NS_ASSUME_NONNULL_END
