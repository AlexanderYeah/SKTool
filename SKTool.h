//
//  SKTool.h
//  SmartFire
//
//  Created by AY on 2017/11/23.
//  Copyright © 2017年 xunli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKTool : NSObject

/**  将时间戳字符串转换为时间 */
+ (NSString *)changeTimestampWithStr:(NSString *)stamp;



/** 输入省份的名字 获取对应的省份编码code */
+ (NSString *)getProviceCodeWithString:(NSString *)provinceStr;

/** 输入城市的名字 获取对应的城市编码code */
+ (NSString *)getCityCodeWithString:(NSString *)cityStr;

/** 输入区域的名字 获取对应的区域编码code */
+ (NSString *)getAreaCodeWithString:(NSString *)areaStr;

/** 判断手机号是否是争取的手机号码  如果运营商新增加号段的话 也要加进去，否则就会有问题 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/** 判断是否是银行卡号 */
+ (BOOL)isBankCard:(NSString *)cardNumber;



@end
