//
//  SC+CoreDataProperties.h
//  数据库作业
//
//  Created by apple on 2019/6/6.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "SC+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SC (CoreDataProperties)

+ (NSFetchRequest<SC *> *)fetchRequest;

@property (nonatomic) int32_t grade;
@property (nullable, nonatomic, copy) NSString *sNo;
@property (nullable, nonatomic, copy) NSString *cNo;

@end

NS_ASSUME_NONNULL_END
