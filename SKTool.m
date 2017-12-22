//
//  SKTool.m
//  SmartFire
//
//  Created by AY on 2017/11/23.
//  Copyright © 2017年 xunli. All rights reserved.
//

#import "SKTool.h"

@implementation SKTool

/** 时间戳转为时间 */
+ (NSString *)changeTimestampWithStr:(NSString *)stamp
{
	
    NSTimeInterval time=[stamp doubleValue]+28800 ;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time / 1000];
    NSLog(@"date:%@",[detaildate description]);
//实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
 
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
	
	return currentDateStr;
}


/** 输入省份的名字 获取对应的省份编码code */
+ (NSString *)getProviceCodeWithString:(NSString *)provinceStr
{
	 // 获取文件路径  
    NSString *path = [[NSBundle mainBundle] pathForResource:@"province_code" ofType:@"json"];
    // 将文件数据化  
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];  
    // 对数据进行JSON格式化并返回字典形式  
    NSDictionary *provinceDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
	NSArray *provinceArr = provinceDic[@"provice_code"];
	for (NSDictionary *dic in provinceArr) {
		if ([dic[@"name"] isEqualToString:provinceStr]) {
			return dic[@"code"];
		}
	}
	return @"NO";
}


/** 输入城市的名字 获取对应的省份编码code */
+ (NSString *)getCityCodeWithString:(NSString *)cityStr{
	// 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"province_code" ofType:@"json"];
    // 将文件数据化  
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];  
    // 对数据进行JSON格式化并返回字典形式  
    NSDictionary *cityDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
	
	NSArray *cityArr = cityDic[@"city_code"];
	
	
	for (NSDictionary *dic in cityArr) {
		if ([dic[@"name"] isEqualToString:cityStr]) {
			return dic[@"code"];
		}
	}
	return @"NO";
}
/** 输入区域的名字 获取对应的区域编码code */
+ (NSString *)getAreaCodeWithString:(NSString *)areaStr{
	
	// 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"province_code" ofType:@"json"];
    // 将文件数据化  
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];  
    // 对数据进行JSON格式化并返回字典形式  
    NSDictionary *areaDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
	NSArray *areaArr = areaDic[@"area_code"];
	for (NSDictionary *dic in areaArr) {
		if ([dic[@"name"] isEqualToString:areaStr]) {
			return dic[@"code"];
		}
	}
	
	return @"NO";
}


+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码: 
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];

    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


// 银行卡正则表达式验证
+ (BOOL)isBankCard:(NSString *)cardNumber

{

	if(cardNumber.length==0){

		return NO;
	}

	NSString *digitsOnly = @"";

	char c;

	for (int i = 0; i < cardNumber.length; i++)

	{

		c = [cardNumber characterAtIndex:i];

		if (isdigit(c))

		{

		digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];

		}

	}

	int sum = 0;

	int digit = 0;

	int addend = 0;

	BOOL timesTwo = false;

	for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)

	{

	digit = [digitsOnly characterAtIndex:i] - '0';

	if (timesTwo)

	{

	addend = digit * 2;

	if (addend > 9) {

		addend -= 9;

		}

	}

	else {

	addend = digit;

	}

	sum += addend;

	timesTwo = !timesTwo;

	}

	int modulus = sum % 10;

	return modulus == 0;

}

@end
