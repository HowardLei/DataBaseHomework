//
//  Users+CoreDataProperties.h
//  数据库作业
//
//  Created by apple on 2019/6/6.
//  Copyright © 2019 ITCenter. All rights reserved.
//
//

#import "Users+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Users (CoreDataProperties)

+ (NSFetchRequest<Users *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, copy) NSString *userMode;
@property (nullable, nonatomic, copy) NSString *userName;

@end

NS_ASSUME_NONNULL_END
