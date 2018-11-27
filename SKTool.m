//
//  SKTool.m
//  SmartFire
//
//  Created by AY on 2017/11/23.
//  Copyright © 2017年 xunli. All rights reserved.
//

#import "SKTool.h"
#import <CoreText/CoreText.h>
@implementation SKTool

+ (NSString *)getCurrentDateStrWithSepStr:(NSString *)sepStr
{

	NSDate *currentDate = [NSDate date];//获取当前时间，日期
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	if (sepStr == nil) {
    	[dateFormatter setDateFormat:@"YYYY/MM/dd"];
	}else if ([sepStr isEqualToString:@"."]){
		[dateFormatter setDateFormat:@"YYYY.MM.dd"];
	}else if ([sepStr isEqualToString:@"-"]){
		[dateFormatter setDateFormat:@"YYYY-MM-dd"];
	}
	
	NSString *dateString = [dateFormatter stringFromDate:currentDate];
	return dateString;

}


+ (NSString *)getCurrentDateStrWithSepStr:(NSString *)sepStr haveMin:(BOOL)haveMin
{

	NSDate *currentDate = [NSDate date];//获取当前时间，日期
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	if (sepStr == nil) {
		if (haveMin) {
			[dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm"];
		}else{
			[dateFormatter setDateFormat:@"YYYY/MM/dd"];
		}
	}else if ([sepStr isEqualToString:@"."]){
		if (haveMin) {
			[dateFormatter setDateFormat:@"YYYY.MM.dd hh:mm"];
		}else{
			[dateFormatter setDateFormat:@"YYYY.MM.dd"];
		}
		
	}else if ([sepStr isEqualToString:@"-"]){
		if (haveMin) {
			[dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm"];
		}else{
			[dateFormatter setDateFormat:@"YYYY-MM-dd"];
		}
		
	}
	
	
	
	NSString *dateString = [dateFormatter stringFromDate:currentDate];
	return dateString;

}

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


/**  MARK: 改变一个字符串指定起始结束位置的颜色 大小 */
+ (NSMutableAttributedString *)changeStringColorWithString:(NSString *)str Color:(UIColor *)color fontSize:(CGFloat )font startIndex:(NSInteger)startIdx endIndex:(NSInteger)endIdx{
	
	NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
    // 需要改变的第一个文字的位置
    NSUInteger firstLoc = startIdx;
    // 需要改变的最后一个文字的位置
    NSUInteger secondLoc = endIdx;
	
	secondLoc = secondLoc > str.length ? str.length : secondLoc;
    // 需要改变的区间
    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:range];
	[noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
	
	return noteStr;

}

/** MARK: 改变textfield holer的字体 */
+(UITextField *)changeTextfield:(UITextField *)textfield holderColor:(UIColor *)color holderFont:(CGFloat)fontSize
{
	
	[textfield setValue:color forKeyPath:@"_placeholderLabel.textColor"];
	[textfield setValue:[UIFont boldSystemFontOfSize:fontSize] forKeyPath:@"_placeholderLabel.font"];
	return textfield;
}




/** MARK:判断一个字符书不是中文。主要是将oc字符串转成c的字符串(char*)，然后判断c的字符串的长度，因为中文字符占得长度是英文字符的两倍。*/
+(BOOL)isContainChinese:(NSString*)string{

    int strlength = 0;
    char* p = (char*)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {

            p++;

            strlength++;

        }

        else {

            p++;

        }

    }

    return ((strlength/2)==1)?YES:NO;

}

/** MARK: 是否包含字母和数字 */
+(BOOL)isStringContainNumberAndLetterWith:(NSString *)str {

	NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"A-Za-z0-9]" options:NSRegularExpressionCaseInsensitive error:nil];

	NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];

//count是str中包含[A-Za-z0-9]数字的个数，只要count>0，说明str中包含数字

	if (count > 0) {

		return YES;

	}

	return NO;

}

/** MARK: 是否只包含数字 使用NSScaner*/
+(BOOL)isPureNumberString:(NSString *)string{
	
	NSScanner* scan = [NSScanner scannerWithString:string];
	int val;
	// - (BOOL)scanInt:(int *)value;  //是否找到一个十进制 int
	return [scan scanInt:&val] && [scan isAtEnd];

}

#pragma mark - 改变字符串的字间距
/**
 *  单纯改变句子的字间距（需要 <CoreText/CoreText.h>）
 *
 *  @param targetString 需要更改的字符串
 *  @param space       字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)sk_changeStringSpaceWithTargetString:(NSString *)targetString Space:(CGFloat)space{
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:targetString];
    long number = space;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedStr length])];
    CFRelease(num);
    return attributedStr;
    
}
#pragma mark - 改变字符串的行间距
/**
 *  单纯改变段落的行间距
 *
 *  @param targetString 需要更改的字符串
 *  @param lineSpace   行间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)sk_changeLineSpaceWithTargetString:(NSString *)targetString LineSpace:(CGFloat)lineSpace{
    
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:targetString];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [targetString length])];
    return attributedStr;
    
}

#pragma mark - 改变字符串行间距和竖间距
/**
 *  同时更改行间距和字间距
 *
 *  @param targetString 需要改变的字符串
 *  @param rowSpace   行间距
 *  @param colSpace   字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)sk_changeColAndRowSpaceWithTargetString:(NSString *)targetString rowSpace:(CGFloat)rowSpace colSpace:(CGFloat)colSpace
{
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:targetString];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:rowSpace];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [targetString length])];
    long number = colSpace;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedStr length])];
    CFRelease(num);
    return attributedStr;
    
}

#pragma mark - 改变某些文字的颜色 并单独设置其字体
/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param targetString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)sk_changeFontAndColor:(UIFont *)font Color:(UIColor *)color TargetString:(NSString *)targetString SubStringArray:(NSArray *)subArray
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:targetString];
    
    for (NSString *rangeStr in subArray) {
        
        NSRange range = [targetString rangeOfString:rangeStr options:NSBackwardsSearch];
        
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    
    return attributedStr;
    
}
#pragma mark - 改变一句话中的某些字的颜色
/**
 *  单纯改变一句话中的某些字的颜色（一种颜色）改变所有
 *
 *  @param color    需要改变成的颜色
 *  @param targetString 总的字符串
 *  @param subArray 需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)sk_changeCorlorWithColor:(UIColor *)color TargetString:(NSString *)targetString SubStringArray:(NSArray *)subArray{
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:targetString];
    for (NSString *rangeStr in subArray) {
        
        NSMutableArray *array = [self sk_getRangeWithTotalString:targetString SubString:rangeStr];
        
        for (NSNumber *rangeNum in array) {
            
            NSRange range = [rangeNum rangeValue];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
        
    }
    
    return attributedStr;
    
}




#pragma mark - 6 Extract Method
/**
 *  获取某个字符串中子字符串的位置数组
 *
 *  @param totalString 总的字符串
 *  @param subString   子字符串
 *
 *  @return 位置数组
 */
+ (NSMutableArray *)sk_getRangeWithTotalString:(NSString *)totalString SubString:(NSString *)subString {
    
    NSMutableArray *arrayRanges = [NSMutableArray array];
    
    if (subString == nil && [subString isEqualToString:@""]) {
        return nil;
    }
    
    NSRange rang = [totalString rangeOfString:subString];
    
    if (rang.location != NSNotFound && rang.length != 0) {
        
        [arrayRanges addObject:[NSNumber valueWithRange:rang]];
        
        NSRange      rang1 = {0,0};
        NSInteger location = 0;
        NSInteger   length = 0;
        
        for (int i = 0;; i++) {
            
            if (0 == i) {
                
                location = rang.location + rang.length;
                length = totalString.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            } else {
                
                location = rang1.location + rang1.length;
                length = totalString.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            
            rang1 = [totalString rangeOfString:subString options:NSCaseInsensitiveSearch range:rang1];
            
            if (rang1.location == NSNotFound && rang1.length == 0) {
                
                break;
            } else {
                
                [arrayRanges addObject:[NSNumber valueWithRange:rang1]];
            }
        }
        
        return arrayRanges;
    }
    
    return nil;
}


@end
