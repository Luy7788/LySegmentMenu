//
//  LySegmentMenu.m
//  LySegmentMenu
//
//  Created by Lying on 16/6/27.
//  Copyright © 2016年 Lying. All rights reserved.
//

#import "LySegmentMenu.h"
#import "UIColor+Hex.h"
#import "HeaderToolScrollBar.h"

@interface LySegmentMenu ()<UIScrollViewDelegate,HeaderToolBarDelegate>

@property (nonatomic ,strong) HeaderToolScrollBar           *headerToolBar;
@property (nonatomic ,assign) CGRect                        childFrame;
@property (nonatomic ,strong) UIScrollView                  *scrollView;
@property (nonatomic ,strong) NSArray                       *viewArr;

@end

@implementation LySegmentMenu


-(instancetype)initWithFrame:(CGRect)frame ControllerViewArray:(NSArray *)viewArr TitleArray:(NSArray *)titleArr {
    
    if(self = [super initWithFrame:frame]){
        
       self = [self initWithFrame:frame ControllerViewArray:viewArr TitleArray:titleArr MaxShowTitleNum:HeaderToolBar_MaxShowTitleNum];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame ControllerViewArray:(NSArray *)viewArr TitleArray:(NSArray *)titleArr MaxShowTitleNum:(NSInteger)maxNum{
    
    if(self = [super initWithFrame:frame]){
        
        if(titleArr.count==0 || viewArr.count==0 || viewArr.count != titleArr.count){
            return nil;
        }
        
        if([titleArr[0] isKindOfClass:[NSString class]] && [viewArr[0] isKindOfClass:[UIView class]]){
            
            CGFloat x = 0;
            CGFloat y = HeaderToolBar_Height;
            CGFloat w = frame.size.width;
            CGFloat h = frame.size.height - y;
            self.childFrame = CGRectMake(x,y,w,h);
            
            self.headerToolBar = [[HeaderToolScrollBar alloc] initWithFrame:CGRectMake(0, 0, w, HeaderToolBar_Height)];
            self.headerToolBar.customDelegate = self;
            [self addSubview:self.headerToolBar];
            [self.headerToolBar configWithTitleArray:titleArr MaxShowNum:maxNum];
            
            self.viewArr = viewArr;
            
            UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:_childFrame];
            y = 0;
            x += 0;
            UIView *view = viewArr[0];
            view.frame = CGRectMake(x,y,w,h);
            [scrollView addSubview:view];
            x += w * (viewArr.count-1);
            scrollView.contentSize = CGSizeMake(x + w, h);
            scrollView.pagingEnabled = YES;
            [self addSubview:scrollView];
            self.scrollView = scrollView;
            self.scrollView.delegate = self;
            self.scrollView.showsHorizontalScrollIndicator = NO;
            
        }else{
            return nil;
        }

    }
    
    return self;
}




#pragma mark ---------- HeaderToolBar Delegate
- (void)HeaderToolScrollBar:(HeaderToolScrollBar *)headerToolBar didSelectItemWithTitle:(NSString *)title withIndex:(NSInteger)index{
    NSLog(@"*****%@",title);
    
    CGFloat x = self.childFrame.origin.x;
    CGFloat y = 0;
    CGFloat w = self.childFrame.size.width;
    CGFloat h = self.childFrame.size.height;
    
    x += index * w;
    [self.scrollView scrollRectToVisible:CGRectMake(x, y, w , h) animated:NO];
    
    if([self.delegate respondsToSelector:@selector(LySegmentMenuCurrentView:didSelectItemWithIndex:)]){
        [self.delegate LySegmentMenuCurrentView:self.viewArr[index] didSelectItemWithIndex:index];
    }
}

#pragma mark - scrollView代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x / self.childFrame.size.width;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.childFrame.size.width;
    CGFloat h = self.childFrame.size.height;
    x += w *page;
    
    if(page > self.viewArr.count-1)
        page = self.viewArr.count-1;
    if(![self.viewArr[page] isDescendantOfView:self.scrollView]){
        UIView *view = self.viewArr[page];
        view.frame = CGRectMake(x,y,w,h);
        [scrollView addSubview:view];
    }
    [self.headerToolBar changeSelectItemWithIndex:page];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x / self.childFrame.size.width;
    [self.headerToolBar changeSelectItemWithIndex:page];
    
    if([self.delegate respondsToSelector:@selector(LySegmentMenuCurrentView:didSelectItemWithIndex:)]){
        [self.delegate LySegmentMenuCurrentView:self.viewArr[page] didSelectItemWithIndex:page];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x / self.childFrame.size.width;
    [self.headerToolBar changeSelectItemWithIndex:page];
    
    if([self.delegate respondsToSelector:@selector(LySegmentMenuCurrentView:didSelectItemWithIndex:)]){
        [self.delegate LySegmentMenuCurrentView:self.viewArr[page] didSelectItemWithIndex:page];
    }
}

 
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
