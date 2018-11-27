//
//  SKTool.h
//  SmartFire
//
//  Created by AY on 2017/11/23.
//  Copyright © 2017年 xunli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SKTool : NSObject





/**  获取当前的时间 */


+ (NSString *)getCurrentDateStrWithSepStr:(NSString *)sepStr;

+ (NSString *)getCurrentDateStrWithSepStr:(NSString *)sepStr haveMin:(BOOL)haveMin;


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

/** 改变一个字符串指定起始结束位置的颜色 大小 */
+ (NSMutableAttributedString *)changeStringColorWithString:(NSString *)str Color:(UIColor *)color fontSize:(CGFloat)font startIndex:(NSInteger)startIdx endIndex:(NSInteger)endIdx;

/** 改变一个textfieldholder的颜色以及大小 */
+ (UITextField *)changeTextfield:(UITextField *)textfield holderColor:(UIColor *)color holderFont:(CGFloat)fontSize;

/** 是否包含中文 */
+(BOOL)isStringContainNumberAndLetterWith:(NSString *)str;

/** MARK: 是否只包含数字 使用NSScaner*/
+(BOOL)isPureNumberString:(NSString *)string;


/**单纯改变句子的字间距*/
+ (NSMutableAttributedString *)sk_changeStringSpaceWithTargetString:(NSString *)targetString Space:(CGFloat)space;

/**  单纯改变段落的行间距 */
+ (NSMutableAttributedString *)sk_changeLineSpaceWithTargetString:(NSString *)targetString LineSpace:(CGFloat)lineSpace;

/** 同时更改行间距和字间距*/
+ (NSMutableAttributedString *)sk_changeColAndRowSpaceWithTargetString:(NSString *)targetString rowSpace:(CGFloat)rowSpace colSpace:(CGFloat)colSpace;

/**
 *  改变某些文字的颜色 并单独设置其字体 改变最后一个
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param targetString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)sk_changeFontAndColor:(UIFont *)font Color:(UIColor *)color TargetString:(NSString *)targetString SubStringArray:(NSArray *)subArray;

/**
 *  单纯改变一句话中的某些字的颜色（一种颜色）改变所有
 *
 *  @param color    需要改变成的颜色
 *  @param targetString 总的字符串
 *  @param subArray 需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)sk_changeCorlorWithColor:(UIColor *)color TargetString:(NSString *)targetString SubStringArray:(NSArray *)subArray;



@end
