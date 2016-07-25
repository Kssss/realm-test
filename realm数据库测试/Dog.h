//
//  Dog.h
//  realm数据库测试
//
//  Created by Vieene on 16/7/25.
//  Copyright © 2016年 hhly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/RLMObject.h>

@interface Dog : RLMObject
@property NSString *name;
@property NSInteger age;
@end
