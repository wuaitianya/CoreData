//
//  ViewController.m
//  CoreDataProject
//
//  Created by alex black on 2019/3/20.
//  Copyright © 2019 JTB.com. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "User.h"
@interface ViewController ()
@property (nonatomic,strong) NSManagedObjectContext *context;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // https://blog.csdn.net/li123128/article/details/80894457
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    //CoreDataProject.xcdatamodeld文件 编译后就是 CoreDataProject.momd 所以名字要对应
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"CoreDataProject" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/People.sqlite"];//自己定义的数据库名字 千万别忘记加/ 否则真机无法创建相应文件
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];

    context.persistentStoreCoordinator = coordinator;
    self.context = context;
}
#pragma mark - 插入操作
- (void)insertMethod:(NSManagedObjectContext*)context
{
    //@"UserEntity" 要和 CoreDataProject.xcdatamodeld文件中定义的model名字一样  特别注意：User中的属性描述必须和UserEntity的属性描述一致，否则无法存入，例如User的height是CGFloat 而 UserEntity的height是Float，类型不一致无法存入信息，也无法修改
    User* obj =  (User*)[NSEntityDescription insertNewObjectForEntityForName:@"UserEntity" inManagedObjectContext:context];
    obj.name = @"ee";
    obj.sex = YES;
    obj.age = 18;
    obj.height = 180;
    
    User* obj2 =  (User*)[NSEntityDescription insertNewObjectForEntityForName:@"UserEntity" inManagedObjectContext:context];
    obj2.name = @"pp";
    obj2.sex = NO;
    obj2.age = 16;
    obj2.height = 160;
    
    NSError *error1;
    if (context.hasChanges) {
        [context save:&error1];
    }
    if (error1) {
        NSLog(@"error1 = %@",error1);
    }
}
#pragma mark - 删除操作
- (void)deleteMethod:(NSManagedObjectContext*)context{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserEntity"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@",@"ee"];
    request.predicate = predicate;
    NSError *error2;
    NSArray<User*> *deleteArr = [context executeFetchRequest:request error:&error2];
    [deleteArr enumerateObjectsUsingBlock:^(User * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [context deleteObject:obj];
    }];
    if ([context hasChanges]) {
        [context save:nil];
    }
    if (error2) {
        NSLog(@"%@",error2);
    }
}
#pragma mark - 修改操作
- (void)changeMethod:(NSManagedObjectContext*)context{
    NSFetchRequest *request1 = [NSFetchRequest fetchRequestWithEntityName:@"UserEntity"];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"name=%@",@"pp"];
    request1.predicate = predicate1;
    NSError *error3 = nil;
    NSArray<User*> *chageArr = [context executeFetchRequest:request1 error:&error3];
    [chageArr enumerateObjectsUsingBlock:^(User * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.height = 133;
    }];
    if ([context hasChanges]) {
        [context save:nil];
    }
    if (error3) {
        NSLog(@"%@",error3);
    }
}
#pragma mark - 查找操作
- (void)queryMethod:(NSManagedObjectContext*)context{
    NSFetchRequest *request4 = [NSFetchRequest fetchRequestWithEntityName:@"UserEntity"];
    NSError *error4 = nil;
    NSArray<User *> *quertArr = [context executeFetchRequest:request4 error:&error4];
    [quertArr enumerateObjectsUsingBlock:^(User * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"User Name : %@, Height : %@, age : %d", obj.name, @(obj.height), obj.age);
    }];
    
    // 错误处理
    if (error4) {
        NSLog(@"%@", error4);
    }
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 1) {
        [self insertMethod:self.context];
    }else if (sender.tag == 2) {
        [self deleteMethod:self.context];
    }else if (sender.tag == 3) {
        [self changeMethod:self.context];
    }else if (sender.tag == 4) {
        [self queryMethod:self.context];
    }
}

@end
