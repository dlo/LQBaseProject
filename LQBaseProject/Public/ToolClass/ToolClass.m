//
//  ToolClass.m
//  Xuebei
//
//  Created by maceasy on 15/11/27.
//  Copyright © 2015年 macHY. All rights reserved.
//

#import "ToolClass.h"

@implementation ToolClass



#pragma mark - 是否是iphone4 iphone4s
+(BOOL)mIsIphone4Or4s{
    
    CGSize  rect = [UIScreen mainScreen].bounds.size;
    if (rect.width == 320 && rect.height == 480) {
        return YES;
    }
    return NO;
}

#pragma mark - mIsIphone5
+(BOOL)mIsIphone5{
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGFloat scale = [UIScreen mainScreen].scale;
    return (bounds.size.height * scale == 1136.0 && bounds.size.width * scale == 640.0) ? YES :NO;
}


#pragma mark - mIsIphone6
+(BOOL)mIsIphone6{
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGFloat scale = [UIScreen mainScreen].scale;
    return (bounds.size.height * scale == 1334.0 && bounds.size.width * scale == 750.0) ? YES :NO;
}


#pragma mark -mIsIphone6plus
+(BOOL)mIsIphone6plus{
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGFloat scale = [UIScreen mainScreen].scale;
    return (bounds.size.height*scale == 2208.0 && bounds.size.width*scale == 1242.0) ? YES :NO;;
}


#pragma mark - 获取路径
+(NSString *)mGetLibraryCachesPath:(NSString *)fileName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [[paths lastObject] stringByAppendingPathComponent:fileName];
}


#pragma mark - 删除指定字符串
+(NSString *)mDeleteDesignatedString:(NSString *)str
{
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if ( c == '"' || c == '.' || c == ',' || c == '(' || c == ')'|| c == ' '|| c == '5') { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSLog(@"输出执行了删除");
    NSString *newstr = [NSString stringWithString:str1];
    return newstr;
}

#pragma mark -判断字符串内容是否全部为空格(能用),yes全部为空格，no不是
//判断字符串内容是否全部为空格，yes全部为空格，no不是
+(BOOL)mStringisEmpty:(NSString *) str {
    
    if (!str) {
        return YES;
    } else {
        
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}

//#pragma mark -检测是否为数字
#pragma mark- 判是数字的正则表达式
+(BOOL)mJudgePassWordLegal:(NSString *) pass{
    BOOL result = false;
    
    NSString * regex = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:pass];
    
    NSLog(@"正则表达式输入是否为数字 = %d",result);//是数字打印1，不是为0
    return result;
}


#pragma mark - 判断是否以字母开头
+(BOOL)mJudgeIsLetterFirst:(NSString *)str
{
    //先截取字符串第一个字符（这是判断是否为全字母的）
    NSString *firstStr = [str substringToIndex:1];
    
    //判断是否以字母开头
    NSString *ZIMU = @"^[A-Za-z]+$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    
    if ([regextestA evaluateWithObject:firstStr] == YES)
        
        return YES;
    
    else
        return NO;
}

#pragma mark - 判断是否为中文开头
+(BOOL)mJudgeisChineseFirst:(NSString *)str
{
    //先截取字符串第一个字符（这是判断是否为全字母的）
    NSString *firstStr = [str substringToIndex:1];
    
    //是否以中文开头(unicode中文编码范围是0x4e00~0x9fa5)
    int utfCode = 0;
    void *buffer = &utfCode;
    NSRange range = NSMakeRange(0, 1);
    //判断是不是中文开头的,buffer->获取字符的字节数据 maxLength->buffer的最大长度 usedLength->实际写入的长度，不需要的话可以传递NULL encoding->字符编码常数，不同编码方式转换后的字节长是不一样的，这里我用了UTF16 Little-Endian，maxLength为2字节，如果使用Unicode，则需要4字节 options->编码转换的选项，有两个值，分别是NSStringEncodingConversionAllowLossy和NSStringEncodingConversionExternalRepresentation range->获取的字符串中的字符范围,这里设置的第一个字符 remainingRange->建议获取的范围，可以传递NULL
    BOOL b = [firstStr getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
    if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5))
        return YES;
    else
        return NO;
}



#pragma mark - 每次输入减一个字符
+(NSString *)mInputReduceCharacter:(NSString *)str{
    
    NSString *myStr = [str substringToIndex: str.length - 1];
    return myStr;
    
}

#pragma mark - 删除字符的首尾空格(OK)
+(NSString *)mDeleteBeginningAndEndSpace:(NSString *)str{
    
    NSString *content = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return content;
}

#pragma mark - 删除字符串里面的空格、换行、和括号(OK)
+ (NSString *)mDeleteSpaceAndEnterElementWithString:(NSString *)sourceStr

{
    
    NSString *realSre = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *realSre1 = [realSre stringByReplacingOccurrencesOfString:@"\r" withString:@""];//回车
    
    NSString *realSre2 = [realSre1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];//换行
    
    NSString *realSre3 = [realSre2 stringByReplacingOccurrencesOfString:@" " withString:@""];//空格
    
    NSString *realSre4 = [realSre3 stringByReplacingOccurrencesOfString:@"(" withString:@""];//括号
    
    NSString *realSre5 = [realSre4 stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    NSArray *array = [realSre5 componentsSeparatedByString:@","];
    
    return [array objectAtIndex:0];
    
}

#pragma mark - 单独删除字符串内所有空格（ok）
+(NSString *)mDeleteAllSpaceString:(NSString *)str{
    
    NSString *realSre = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *realSre1 = [realSre stringByReplacingOccurrencesOfString:@" " withString:@""];
    return realSre1;
}


/*
 ** lineFrame:     虚线的 frame
 ** length:        虚线中短线的宽度
 ** spacing:       虚线中短线之间的间距
 ** color:         虚线中短线的颜色
 */
+ (UIView *)mCreateDashedLineWithFrame:(CGRect)lineFrame
                            lineLength:(int)length
                           lineSpacing:(int)spacing
                             lineColor:(UIColor *)color{
    
    
    UIView *dashedLine = [[UIView alloc] initWithFrame:lineFrame];
    dashedLine.backgroundColor = [UIColor clearColor];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:dashedLine.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(dashedLine.frame) / 2, CGRectGetHeight(dashedLine.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:color.CGColor];
    [shapeLayer setLineWidth:CGRectGetHeight(dashedLine.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:length], [NSNumber numberWithInt:spacing], nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(dashedLine.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [dashedLine.layer addSublayer:shapeLayer];
    return dashedLine;
}

#pragma mark - 获取GUID - （这个是UUID）
+(NSString *)mGetUUID{
    
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    
    return uuidString;
}


#pragma mark - 字符串每隔3位添加逗号，
+(NSString *)mCountNumAndChangeformat:(NSString *)num{
    
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}



//计算一个label的大小,labelText 是字符串，postLabelMaxWidth是什么范围内的宽度，space 应该是nsstring距离label 的边界距离
+(CGSize)mCalculateVerticalSize:(NSString *)labelText postLabelMaxWidth:(CGFloat)postLabelMaxWidth font:(UIFont*)font defaultSpace:(CGFloat)space{
    
    //UIFont *font = [UIFont fontWithName:@"NotoSansHans-DemiLight" size:FONT_SIZE];
    NSDictionary *cellTextDic=nil;
    if (space!=0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:space];
        cellTextDic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    }else{
        cellTextDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    }
    
    
    //根据控件的大小和控件之间的距离，和手机屏幕的宽度，动态计算label的最长长度
    //int postLabelMaxWidth = [UIScreen mainScreen].bounds.size.width - 2*16;  //16是距离左右边框的距离
    CGSize labelSize = [labelText boundingRectWithSize:CGSizeMake(postLabelMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:cellTextDic context:nil].size;
    return  CGSizeMake(ceil(labelSize.width), ceil(labelSize.height));// labelSize;
}


/**   单行的label的frame 根据nsstring返回大小  */
+(CGSize)mGetSingleLineSize:(UILabel *)label labelFont:(UIFont *)font{
    
    // 设置Label的字体 HelveticaNeue  Courier
    //    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:24.0f];
    // 设置Label的字体
    label.font = font;
    // 根据字体得到NSString的尺寸
    CGSize size = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    return size;
}


//图片压缩函数
+(UIImage *)mImageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}









@end

