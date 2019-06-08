//
//  Student+CoreDataProperties.h
//  数据库作业
//
//  Created by apple on 2019/6/8.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *sDept;
@property (nullable, nonatomic, copy) NSString *sName;
@property (nullable, nonatomic, copy) NSString *sNo;
@property (nullable, nonatomic, retain) Course *course;

@end

NS_ASSUME_NONNULL_END
