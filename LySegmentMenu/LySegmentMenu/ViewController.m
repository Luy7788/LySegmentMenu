//
//  ViewController.m
//  LyScrollMenu
//
//  Created by Lying on 16/6/27.
//  Copyright © 2016年 Lying. All rights reserved.
//

// 获得屏幕尺寸
#define kSCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define kSCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height

#import "ViewController.h"
#import "LySegmentMenu.h"

#import "SecondViewController.h"


@interface ViewController ()<LySegmentMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    
//    UIViewController *VC1 = [[UIViewController alloc]init];
//    [VC1.view setBackgroundColor:[UIColor redColor]];
    SecondViewController *VC1 = [[SecondViewController alloc]init];
    [VC1.view setBackgroundColor:[UIColor redColor]];
    [self addChildViewController:VC1];
    
    UIViewController *VC2 = [[UIViewController alloc]init];
    [VC2.view setBackgroundColor:[UIColor blueColor]];
    UIViewController *VC3 = [[UIViewController alloc]init];
    [VC3.view setBackgroundColor:[UIColor grayColor]];
    UIViewController *VC4 = [[UIViewController alloc]init];
    [VC4.view setBackgroundColor:[UIColor greenColor]];
    UIViewController *VC5 = [[UIViewController alloc]init];
    [VC5.view setBackgroundColor:[UIColor purpleColor]];
    UIViewController *VC6 = [[UIViewController alloc]init];
    [VC6.view setBackgroundColor:[UIColor lightGrayColor]];
    UIViewController *VC7 = [[UIViewController alloc]init];
    [VC7.view setBackgroundColor:[UIColor yellowColor]];
    
    CGRect Rect = CGRectMake(0, 20, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    
    LySegmentMenu *LyMenu = [[LySegmentMenu alloc]initWithFrame:Rect
                                          ControllerViewArray:@[VC1.view,VC2.view,VC3.view,VC4.view,VC5.view,VC6.view,VC7.view]
                                                   TitleArray:@[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5",@"标题6",@"标题7"]
                                              MaxShowTitleNum:4];
    LyMenu.delegate = self;
    [self.view addSubview:LyMenu];
    
    
}


-(void)LySegmentMenuCurrentView:(UIView *)currentView didSelectItemWithIndex:(NSInteger)index{
    NSLog(@"currentView:%@ Index:%d",currentView,index);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
