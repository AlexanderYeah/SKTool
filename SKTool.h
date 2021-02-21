//
//  SKTool.h
//  SmartFire
//
//  Created by AY on 2017/11/23.
//  Copyright © 2017年 si. All rights reserved.
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


/** MARK: 判断数组是否有重复元素*/
+ (BOOL)isArrayContainSameObjWithArr:(NSArray *)resArr;

/** MARK: 判断字符串是否是合法数字*/
+ (BOOL)isMoneyNumber:(NSString *)strValue;
/** MARK: 创建请求结束后的提示AlertView*/
+ (void)createAlertWithStr:(NSString *)str;

/** MARK: 创建请求结束后的提示AlertView 加上秒的提示*/
+ (void)createAlertWithStr:(NSString *)str second:(CGFloat)second;

/** MARK:判断字符串是否为空或者都是空格 */
+ (BOOL)isBlankString:(NSString *)string;
/** MARK:富文本检测所有数字变红 */
+ (NSMutableAttributedString *)getAttributString:(NSString *)normalString Color:(UIColor *)changeColor FontSize:(UIFont *)fontSize;
/** MARK:获取字符串自适应后所占宽度 */
+ (CGFloat)widthOfStr:(NSString *)str
                 font:(UIFont *)font
               height:(CGFloat)height;

/** MARK:获取字符串自适应后所占高度 */

+ (CGFloat)getHeightOfStr:(NSString *)str
                     font:(UIFont *)font
                    width:(CGFloat)width;




/** MARK: 数组字典转为json字符串 */
+(NSString*)transferDataTOjsonString:(id)object;


/** MARK: json字符串 转换为数组字典 */
+(id)transferJsonStringTOData:(NSString *)string;



/** MARK: 改变按钮的图片文子位置
0 为 上图片 下文字
1 为 下图片 上文字
 */
+ (UIButton *)changeBtnTitleAndImageLocationWithType:(NSInteger)type btn:(UIButton *)btn;

/** MARK: 找到某个字符第一次出现的位置
 */

+ (NSInteger)findTargetIdx:(NSString *)targetStr parrentStr:(NSString *)parrentStr;
/** MARK:获取UUID*/
+ (NSString *)getUUID;

/** MARK: 找到某个字符第一次出现的位置
 */
+ (NSString *)getDateFromTodayDateStr:(NSString *)targetDateStr;

/** MARK: 将时间字符串转换为NSDate 格式*/
+ (NSDate *)changeTimeStringtoDate:(NSString *)dateStr;

/** MARK: 去除空格和换行*/
+ (NSString *)removeSpaceAndNewline:(NSString *)str;

+ (NSString *)removeSpace:(NSString *)str;

/** MARK: 输入银行卡号 每隔四位添加一个空格字符串*/
+ (NSString *)getNewBankNumWitOldBankNum:(NSString *)bankNum;

/** MARK: 将字符串金额抓换为万为单位 */
+ (NSString *)formateAmountString:(NSString *)amountStr;


/** MARK: 删除字符串的后面0*/
+ (NSString *)deleteFloatAllZero:(NSString*)string;
 
/** MARK: 计算字符串的高度 */
+(CGFloat)calculatedStringHeight:(NSString *)string WithSize:(CGSize)size font:(CGFloat)fontSize;

/** 根据逗号分割 获取item对应的数量 */
+(CGFloat )seperatedByDouHao:(NSString *)contentStr;


@end
