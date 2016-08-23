//
//  NSString+CalculateFontSize.m
//  LyScrollMenu
//
//  Created by Lying on 16/6/27.
//  Copyright © 2016年 Lying. All rights reserved.
//

#import "NSString+CalculateFontSize.h"

@implementation NSString (CalculateFontSize)

//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
