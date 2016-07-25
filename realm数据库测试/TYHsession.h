//
//  TYHsession.h
//  realm数据库测试
//
//  Created by Vieene on 16/7/25.
//  Copyright © 2016年 hhly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/RLMObject.h>
@interface TYHsession : RLMObject
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *address;




@end
