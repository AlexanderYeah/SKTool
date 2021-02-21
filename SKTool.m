//
//  SKTool.m
//  SmartFire
//
//  Created by AY on 2017/11/23.
//  Copyright © 2017年 xunli. All rights reserved.
//

#import "SKTool.h"

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

/** MARK: 判断数组是否有重复元素*/
+ (BOOL)isArrayContainSameObjWithArr:(NSArray *)resArr
{
    
    NSSet *set = [NSSet setWithArray:resArr];
    return  set.count == resArr.count ? NO : YES;
}

/** MARK: 判断字符串是否是合法数字*/
+ (BOOL)isMoneyNumber:(NSString *)strValue;
{
    if (strValue == nil || [strValue length] <= 0)
    {
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (![strValue isEqualToString:filtered])
    {
        return NO;
    }
    return YES;
}

/** MARK: 创建请求结束后的提示AlertView*/
+ (void)createAlertWithStr:(NSString *)str{
    
    UILabel *alertView = [[UILabel alloc] init];
    CGFloat width = [self widthOfStr:str font:[UIFont systemFontOfSize:16.f] height:40.0];
    if (width + 20 > [UIScreen mainScreen].bounds.size.width) {
        
        
        CGFloat height = [self heightOfStr:str font:[UIFont systemFontOfSize:16.f] width:[UIScreen mainScreen].bounds.size.width - 20.0];
        alertView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 20, height + 24.0);
    }
    else {
        alertView.frame = CGRectMake(0, 0, width + 20, 40.0);
    }
    //    UILabel *alertView =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width + 20, 40.0)];
    alertView.numberOfLines = 0;
    alertView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    alertView.alpha = 0;
    alertView.backgroundColor = [UIColor colorWithRed:40/255.f green:40/255.f blue:40/255.f alpha:1];
    [alertView setText:str];
    [alertView setTextColor:[UIColor whiteColor]];
    [alertView setFont:Font(16.0)];
    alertView.textAlignment = NSTextAlignmentCenter;
    alertView.layer.masksToBounds = YES;
    alertView.layer.cornerRadius = 10.0;
    
    [[[UIApplication sharedApplication].delegate window] addSubview:alertView];
    [UIView animateWithDuration:0.3 animations:^{
        alertView.alpha = 0.9;
    }];
    __weak __typeof(self) weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf selector:@selector(timerAction:) userInfo:@{@"alertView": alertView} repeats:NO];
    
}

/** MARK: 创建请求结束后的提示AlertView second*/
+ (void)createAlertWithStr:(NSString *)str second:(CGFloat)second{
    
    UILabel *alertView = [[UILabel alloc] init];
    CGFloat width = [self widthOfStr:str font:[UIFont systemFontOfSize:16.f] height:40.0];
    if (width + 20 > [UIScreen mainScreen].bounds.size.width) {
        
        CGFloat height = [self heightOfStr:str font:[UIFont systemFontOfSize:16.f] width:[UIScreen mainScreen].bounds.size.width - 20.0];
        alertView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 20, height + 24.0);
    }
    else {
        alertView.frame = CGRectMake(0, 0, width + 20, 40.0);
    }
    //    UILabel *alertView =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width + 20, 40.0)];
    alertView.numberOfLines = 0;
    alertView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    alertView.alpha = 0;
    alertView.backgroundColor = [UIColor colorWithRed:40/255.f green:40/255.f blue:40/255.f alpha:1];
    [alertView setText:str];
    [alertView setTextColor:[UIColor whiteColor]];
    [alertView setFont:Font(16.0)];
    alertView.textAlignment = NSTextAlignmentCenter;
    alertView.layer.masksToBounds = YES;
    alertView.layer.cornerRadius = 10.0;
    
    [[[UIApplication sharedApplication].delegate window] addSubview:alertView];
    [UIView animateWithDuration:0.3 animations:^{
        alertView.alpha = 0.9;
    }];
    __weak __typeof(self) weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:second target:weakSelf selector:@selector(timerAction:) userInfo:@{@"alertView": alertView} repeats:NO];
    
}


/** MARK:判断字符串是否为空或者都是空格 */
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil){
        return YES;
    }
    if (string == NULL){
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]){
        return YES;
    }
    //判断字符串是否全部为空格（[NSCharacterSet whitespaceAndNewlineCharacterSet]去掉字符串两端的空格)
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
        return YES;
    }
    return NO;
}
+ (NSMutableAttributedString *)getAttributString:(NSString *)normalString Color:(UIColor *)changeColor FontSize:(UIFont *)fontSize {
    //方法一
    NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    //取出数组
    NSArray *tempArr = [normalString componentsSeparatedByCharactersInSet:nonDigits];
    
    NSMutableArray *changeArr = [NSMutableArray array];
    for (NSString *tempStr in tempArr) {
        if (tempStr.length > 0) {
            [changeArr addObject:tempStr];
        }
    }
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:normalString];
    
    for (NSString *tempStr in changeArr) {
        
        NSArray *tempArr = [self rangeOfSubString:tempStr inString:normalString];
        
        for (NSString *rangeStr in tempArr) {
            
            NSRange range = NSRangeFromString(rangeStr);
            if (range.location + range.length < normalString.length) {
                
                NSString *tempStr = [normalString substringWithRange:NSMakeRange(range.location + range.length, 1)];
                
                if ([tempStr isEqualToString:@"."]) {
                    range = NSMakeRange(range.location, range.length + 1);
                }                
            }
            [attributedString addAttribute:NSForegroundColorAttributeName
                                     value:changeColor
                                     range:range];
            [attributedString addAttribute:NSFontAttributeName value:fontSize range:range];
        }
        
    }
    
    return attributedString;
}


+ (NSArray *)rangeOfSubString:(NSString *)subStr inString:(NSString *)string {
    
    NSMutableArray *rangeArray = [NSMutableArray array];
    NSString *string1 = [string stringByAppendingString:subStr];
    NSString *temp;
    
    for (int i = 0; i < string.length; i ++) {
        
        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
        if ([temp isEqualToString:subStr]) {
            NSRange range = NSMakeRange(i, subStr.length);
            [rangeArray addObject:NSStringFromRange(range)];
        }
        
    }
    return rangeArray;
}


#pragma mark - 获取字符串自适应后所占宽度
+ (CGFloat)widthOfStr:(NSString *)str
                 font:(UIFont *)font
               height:(CGFloat)height
{
    CGSize rect;
    NSDictionary *dic=@{NSFontAttributeName:font};
    rect = [str boundingRectWithSize:CGSizeMake(10000, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                          attributes:dic context:nil].size;
    
    return rect.width;
}


+ (CGFloat)getHeightOfStr:(NSString *)str
                 font:(UIFont *)font
               width:(CGFloat)width
{
    CGSize rect;
    NSDictionary *dic=@{NSFontAttributeName:font};
    rect = [str boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                          attributes:dic context:nil].size;
    
    return rect.height;
}


/** MARK: 数组字典转为json字符串 */
+(NSString*)transferDataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


/** MARK: json字符串 转换为数组字典 */
+(id)transferJsonStringTOData:(NSString *)string
{
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingMutableContainers) error:&error];
    if (error != nil) {
#ifdef DEBUG
        NSLog(@"fail to get dictioanry or array from JSON: %@, error: %@", string, error);
#endif
    }
    return object;
    
}

/** MARK: 改变按钮的图片文子位置 */
+ (UIButton *)changeBtnTitleAndImageLocationWithType:(NSInteger)type btn:(UIButton *)btn
{
    if (type == 0 ){
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(-btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0.0,0.0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,-btn.imageView.frame.size.height, -btn.titleLabel.bounds.size.width)];
        return btn;
    }else
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0.0,0.0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.imageView.frame.size.height, 0.0,0.0, -btn.titleLabel.bounds.size.width)];
        
        return btn;
        
    }
}

/** MARK: 将时间字符串转换为NSDate 格式*/
+ (NSDate *)changeTimeStringtoDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}




#pragma mark -  Extract Method
+ (void)timerAction:(NSTimer *)timer
{
    UILabel *alertView = [[timer userInfo] objectForKey:@"alertView"];
    // 移除alertView
    [alertView removeFromSuperview];
    alertView = nil;
    
}



+ (CGFloat)heightOfStr:(NSString *)str
                  font:(UIFont *)font
                 width:(CGFloat)width
{
    CGSize rect;
    NSDictionary *dic=@{NSFontAttributeName:font};
    rect = [str boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                          attributes:dic context:nil].size;
    
    return rect.height;
}


/** MARK: 找到某个字符第一次出现的位置
 */

+ (NSInteger)findTargetIdx:(NSString *)targetStr parrentStr:(NSString *)parrentStr
{
    
    if ([parrentStr containsString:targetStr]) {
        
        NSArray *resArr = [parrentStr componentsSeparatedByString:targetStr];
        NSString *firstObj = resArr.firstObject;
        return firstObj.length;        
    }else{
        
        return NSNotFound;
    }

    
}

/** MARK: 获取距离当前日期的时间 */

+ (NSString *)getDateFromTodayDateStr:(NSString *)targetDateStr

{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"newsDate = %@",targetDateStr);
    
    NSDate *newsDateFormatted = [dateFormatter dateFromString:targetDateStr];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [[NSDate alloc] init];
    
    NSTimeInterval time=[current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
    
    int year =((int)time)/(3600*24*30*12);
    
    int month=((int)time)/(3600*24*30);
    
    int days=((int)time)/(3600*24);
    
    int hours=((int)time)%(3600*24)/3600;
    
    int minute=((int)time)%(3600*24)/60;
    
    NSLog(@"time=%f",(double)time);
    
    NSString *dateContent;
    
    if (year!=0) {
        
        dateContent = targetDateStr;
        
    }else if(month!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"  ",month,@"个月前"];
        
    }else if(days!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"  ",days,@"天前"];
        
    }else if(hours!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"  ",hours,@"小时前"];
        
    }else {
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"  ",minute,@"分钟前"];
        
    }
    
    return dateContent;
    
}

/** MARK: 去除空格和换行*/
+ (NSString *)removeSpaceAndNewline:(NSString *)str

{
    
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return temp;
    
}


/** MARK: 输入银行卡号 每隔四位添加一个空格字符串*/
+ (NSString *)getNewBankNumWitOldBankNum:(NSString *)bankNum{
    NSMutableString *mutableStr;
    if (bankNum.length) {
        mutableStr = [NSMutableString stringWithString:bankNum];
        for (int i = 0 ; i < mutableStr.length; i ++) {
            if (i>2&&i<mutableStr.length - 3) {
                //                [mutableStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
            }
        }
        NSString *text = mutableStr;
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        return newString;
    }
    return bankNum;
}
/** MARK: 删除字符串的后面0*/
-(NSString*)deleteFloatAllZero:(NSString*)string

{

    NSArray * arrStr=[string componentsSeparatedByString:@"."];

    NSString *str=arrStr.firstObject;

    NSString *str1=arrStr.lastObject;

    while ([str1 hasSuffix:@"0"]) {

    str1=[str1 substringToIndex:(str1.length-1)];

    }

    return (str1.length>0)?[NSString stringWithFormat:@"%@.%@",str,str1]:str;

}

+ (NSString *)removeSpace:(NSString *)str{
    
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return temp;    
}

+ (NSString *)getUUID
{
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    identifierForVendor = [identifierForVendor stringByReplacingOccurrencesOfString:@"-" withString:@""];    
    return identifierForVendor;
}


+ (CGFloat)seperatedByDouHao:(NSString *)contentStr
{
    CGFloat count = 0.f;
    if (contentStr.length > 0) {
        if ([contentStr containsString:@","]) {
            count = [contentStr componentsSeparatedByString:@","].count;
        }else{
            count = 1.f;
        }
    }
    
    return count;
    
}



/** MARK: 计算字符串的高度 */
+(CGFloat)calculatedStringHeight:(NSString *)string WithSize:(CGSize)size font:(CGFloat)fontSize{
    
    return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.height;
}


/** MARK: 将字符串金额抓换为万为单位 */
+ (NSString *)formateAmountString:(NSString *)amountStr
{
    
    amountStr = [NSString stringWithFormat:@"%.2fw",amountStr.floatValue / 10000];
    
    return amountStr;
    
}

@end
