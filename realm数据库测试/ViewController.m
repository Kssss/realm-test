//
//  ViewController.m
//  realm数据库测试
//
//  Created by Vieene on 16/7/25.
//  Copyright © 2016年 hhly. All rights reserved.
//

#import "ViewController.h"
#import <Realm/Realm.h>
#import "TYHsession.h"
#import "Dog.h"
#import "TableViewController.h"

#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSFileManager defaultManager] removeItemAtURL:[RLMRealmConfiguration defaultConfiguration].fileURL error:nil];
    
    // 创建对象
    Dog *mydog = [[Dog alloc] init];
    mydog.name = @"小黄";
    mydog.age = 9;
    NSLog(@"Name of dog: %@", mydog.name);
    Dog *mydog2 = [[Dog alloc] init];
    mydog2.name = @"大黄x";
    mydog2.age = 10;
    NSLog(@"Name of dog: %@", mydog2.name);

    
    //获取realm
    RLMRealm *realm = [RLMRealm defaultRealm]; // Create realm pointing to default file
    
    // 保存对象
    [realm beginWriteTransaction];
    [realm addObjects:@[mydog,mydog2]];
    [realm commitWriteTransaction];
    
    // 查询
    RLMResults *results = [Dog objectsInRealm:realm where:@"name contains '黄' and age >= 1"];
    NSLog(@"查询 of dogs: %li", (unsigned long)results.count);

    // 深度查询
    RLMResults *results2 = [results objectsWhere:@"age > 9"];
    NSLog(@"深度查询 of dogs: %li", (unsigned long)results2.count);
    
    // 连接对象
    Person *person1 = [[Person alloc] init];
    person1.name = @"Tim";
    [person1.dogs addObject:mydog];
    Person *person2 = [[Person alloc] init];
    person2.name = @"amy";
    [person2.dogs addObject:mydog2];
    
    [realm beginWriteTransaction];
    [realm addObjects:@[person1,person2]];
    [realm commitWriteTransaction];
    
    // 多线程查询1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        RLMRealm *otherRealm = [RLMRealm defaultRealm];
        RLMResults *otherResults = [Dog objectsInRealm:otherRealm where:@"name contains '黄'"];
        NSLog(@"Number of dogs: %li", (unsigned long)otherResults.count);
        for (Dog *dog in otherResults) {
            NSLog(@"thread %@-----dog.name =%@",[NSThread currentThread],dog.name);
        }
    });
    
    sleep(2);
    NSLog(@"----------------------------------------------");

    // 多线程查询2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        RLMRealm *otherRealm = [RLMRealm defaultRealm];
        RLMResults *otherResults = [Person allObjectsInRealm:otherRealm];
        NSLog(@"Number of person: %li", (unsigned long)otherResults.count);
        for (Person *person in otherResults) {
            NSLog(@"thread %@-----dog.name =%@,dogs=%@",[NSThread currentThread],person.name,person.dogs);
        }
    });
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TableViewController *tab = [[TableViewController alloc] init];
    
    [self.navigationController pushViewController:tab animated:YES];
}
/*
 name contains 'x'
 age > 8
 */

@end
