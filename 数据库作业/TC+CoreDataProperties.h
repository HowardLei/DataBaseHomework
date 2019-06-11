//
//  TC+CoreDataProperties.h
//  数据库作业
//
//  Created by apple on 2019/6/11.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "TC+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TC (CoreDataProperties)

+ (NSFetchRequest<TC *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *cNo;
@property (nullable, nonatomic, copy) NSString *tNo;

@end

NS_ASSUME_NONNULL_END
