//
//  User.h
//  CoreDataProject
//
//  Created by alex black on 2019/3/20.
//  Copyright © 2019 JTB.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject
//属性的类型一旦创建不可修改，如需修改，必须删除APP中旧的数据库文件，否则崩溃
@property (nonatomic,strong) NSString* name;
@property (nonatomic,assign) BOOL sex;
@property (nonatomic,strong)UIImageView* image;
@property (nonatomic,strong) NSString* aID;
@property (nonatomic,assign) float height;//和CoreDataProject.xcdatamodeld中的UserEntity中的类型一致，不可以是CGFloat
@property (nonatomic,assign) NSInteger age;
@end

NS_ASSUME_NONNULL_END
