# LyScrollMenu
Segment+页面滑动

使用方法
```
LySegmentMenu.h

/**
 *  初始化方法1
 *  在屏幕内最多显示的标题个数默认为5个
 *
 *  @param frame
 *  @param viewArr      scrollView上要添加的view数组   -> @[VC1.view,VC2.view,VC3.view,VC4.view,VC5.view]
 *  @param titleArr     标题数组    -> @[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5"],
 *  
 */
-(instancetype)initWithFrame:(CGRect)frame ControllerViewArray:(NSArray *)viewArr TitleArray:(NSArray *)titleArr;


/**
 *  初始化方法2
 *  可设置最多显示的标题个数
 *
 *  @param frame
 *  @param viewArr      scrollView上要添加的view数组   -> @[VC1.view,VC2.view,VC3.view,VC4.view,VC5.view]
 *  @param titleArr     标题数组    -> @[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5"]
 *  @param maxNum       在屏幕内最多显示的标题个数
 *
 */
-(instancetype)initWithFrame:(CGRect)frame ControllerViewArray:(NSArray *)viewArr TitleArray:(NSArray *)titleArr MaxShowTitleNum:(NSInteger)maxNum;

/**
 *  代理方法
 *
 *  @param currentView 当前的UIview
 *  @param index       当前view的索引
 */
- (void)LySegmentMenuCurrentView:(UIView *)currentView didSelectItemWithIndex:(NSInteger)index;
```

 ![image](https://github.com/Super-lying/LyScrollMenu/blob/master/ScreenFlow.gif)


例子
```
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


```


