//
//  HeaderToolScrollBar.m
//  LyScrollMenu
//
//  Created by Lying on 16/6/27.
//  Copyright © 2016年 Lying. All rights reserved.
//

#define COLOR_BORDER_GRAY           [UIColor colorWithHexString:@"#dfdfdf"]// 浅边框颜色
#define COLOR_INDICATOR             [UIColor colorWithHexString:@"#139CE6"]// 指示条的颜色
#define Color_DefaultFont_Black     [UIColor colorWithHexString:@"333333"]


#define View_Size_Width     self.frame.size.width
#define View_Size_Height    self.frame.size.height
#define Button_Size_Height  (View_Size_Height - 3)

#define Base_TAG    0


#import "NSString+CalculateFontSize.h"
#import "UIColor+Hex.h"
#import "HeaderToolScrollBar.h"

@interface HeaderToolScrollBar ()
@property (nonatomic ,assign) NSInteger titleCount;
@property (nonatomic ,assign) NSInteger maxShowNum;
@property (nonatomic ,strong) UIView    *indicator;

@end


@implementation HeaderToolScrollBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, View_Size_Height-0.7, View_Size_Width, 0.7)];
        bottomLine.backgroundColor = COLOR_BORDER_GRAY;
        [self addSubview:bottomLine];
        
        self.indicator = [[UIView alloc]init];
        [self.indicator setBackgroundColor:COLOR_INDICATOR];
        [self addSubview:self.indicator];
    }
    return self;
}


- (void)configWithTitleArray:(NSArray *)titleAry MaxShowNum:(NSInteger)maxNum{
    
    self.maxShowNum = maxNum;
    if(maxNum > titleAry.count)
        self.maxShowNum = titleAry.count;
    
    CGFloat btnWidth = View_Size_Width/self.maxShowNum;
    if (titleAry != nil && titleAry.count > 0) {
        
        self.titleCount = titleAry.count;
        for (int i = 0; i < titleAry.count; i ++) {
            NSString *title = titleAry[i];
            CGFloat titleWidth = [title sizeWithFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(btnWidth, View_Size_Height-6)].width + 8;
            CGFloat titleHeight = [title sizeWithFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(btnWidth, View_Size_Height-6)].height + 2;
            UIButton *touchBtn = [[UIButton alloc] initWithFrame:CGRectMake(i*btnWidth, 0, btnWidth, Button_Size_Height)];
            touchBtn.backgroundColor = [UIColor clearColor];
            touchBtn.tag = Base_TAG + i;
            [touchBtn addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake((btnWidth-titleWidth)/2, (View_Size_Height-titleHeight)/2, titleWidth, titleHeight)];
            titleLable.backgroundColor = [UIColor clearColor];
            titleLable.layer.cornerRadius = titleHeight / 2;
            titleLable.layer.masksToBounds = YES;
            titleLable.text = title;
            titleLable.font = [UIFont systemFontOfSize:15];
            titleLable.textAlignment = NSTextAlignmentCenter;
            [titleLable setTextColor:Color_DefaultFont_Black];
            
            [touchBtn addSubview:titleLable];
            [self addSubview:touchBtn];
            
            //默认选择第一个
            if (i == 0) {
                titleLable.textColor = COLOR_INDICATOR;//[UIColor whiteColor];
                //                titleLable.backgroundColor = [UIColor orangeColor];
                
                self.indicator.frame = CGRectMake(0, Button_Size_Height, btnWidth, View_Size_Height - Button_Size_Height);
            }
        }
        
    }
    
    self.contentSize = CGSizeMake(btnWidth * titleAry.count, View_Size_Height);
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
}

- (void)touchButton:(UIButton *)sender{
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *subButton = (UIButton *)subView;
            if (subButton.tag == sender.tag) {
                //在这里拿到点击的button
                UILabel *titleLab = subButton.subviews[0];
                titleLab.textColor = COLOR_INDICATOR;//[UIColor whiteColor];
                //                titleLab.backgroundColor = [UIColor orangeColor];
                
                if (self.customDelegate) {
                    if ([self.customDelegate respondsToSelector:@selector(HeaderToolScrollBar:didSelectItemWithTitle:withIndex:)]) {
                        [self.customDelegate HeaderToolScrollBar:self didSelectItemWithTitle:titleLab.text withIndex:sender.tag-Base_TAG];
                    }
                }
                
            }else{
                UILabel *titleLab = subButton.subviews[0];
                titleLab.textColor = Color_DefaultFont_Black;//[UIColor blackColor];
                titleLab.backgroundColor = [UIColor clearColor];
            }
        }
        
    }
}

-(void)setIndicatorFrameWithIndex:(NSInteger)index{
    
    CGFloat Width = View_Size_Width/self.maxShowNum;
    [UIView animateWithDuration:0.2 animations:^{
        self.indicator.frame = CGRectMake(Width * index, self.indicator.frame.origin.y, Width, self.indicator.frame.size.height);
    } completion:^(BOOL finished) {
    }];
}

- (void)changeSelectItemWithIndex:(NSInteger)index{
    
    if (index < self.titleCount) {
        UIButton *indexBtn;
        
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                UIButton *subButton = (UIButton *)subView;
                if (index == subButton.tag - Base_TAG) {
                    indexBtn = subButton;
                    UILabel *titleLab = subButton.subviews[0];
                    titleLab.textColor = COLOR_INDICATOR;//[UIColor whiteColor];
                    //                    titleLab.backgroundColor = [UIColor orangeColor];
                }else{
                    UILabel *titleLab = subButton.subviews[0];
                    titleLab.textColor = Color_DefaultFont_Black;//[UIColor blackColor];
                    titleLab.backgroundColor = [UIColor clearColor];
                }
            }
        }
        
        if(index+1 >= self.maxShowNum/2+1 && index+1 <= self.titleCount - (self.maxShowNum/2+0)){
            [self scrollRectToVisible:CGRectMake(indexBtn.frame.origin.x - (self.frame.size.width-indexBtn.frame.size.width)/2, 0, self.frame.size.width , self.frame.size.height) animated:YES];
        }
        
        
    }else{
        NSLog(@"下标越界啦啦啦啦啦啦！！！！！！");
    }
    
    [self setIndicatorFrameWithIndex:index];
}

@end
