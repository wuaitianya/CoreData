//
//  AppDelegate.h
//  CoreDataProject
//
//  Created by alex black on 2019/3/20.
//  Copyright © 2019 JTB.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

