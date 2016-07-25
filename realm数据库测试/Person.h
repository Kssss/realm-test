//
//  Person.h
//  realm数据库测试
//
//  Created by Vieene on 16/7/25.
//  Copyright © 2016年 hhly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/realm.h>
#import "Dog.h"
RLM_ARRAY_TYPE(Dog)

@interface Person : RLMObject
@property NSString      *name;
@property RLMArray<Dog> *dogs;

@end
