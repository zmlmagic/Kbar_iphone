//
//  JDScrollView.m
//  JDKaLa
//
//  Created by zhangminglei on 11/12/13.
//  Copyright (c) 2013 张明磊. All rights reserved.
//

#import "JDScrollView.h"
#import "SKUIUtils.h"

@implementation JDScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
        /// 初始化 scrollview
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.bounces = YES;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _scrollView_body = scrollView;
        
        /// 初始化 数组 并添加四张图片
        NSMutableArray *array_scroll = [NSMutableArray arrayWithObjects:@"page1.png",@"page2.png",@"page3.png",@"image4.png",nil];
        _array_scroll = array_scroll;
        
        /// 初始化 pagecontrol
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(225, 130, 20, 18)];
        if(IOS7_VERSION)
        {
            [pageControl setCurrentPageIndicatorTintColor:RGB(232, 108, 154)];
            [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
        }
        pageControl.numberOfPages = [_array_scroll count];
        pageControl.currentPage = 0;
        //[pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
        /// 触摸mypagecontrol触发change这个方法事件
        [self addSubview:pageControl];
        _pageControl_scroll = pageControl;
        
        /// 创建四个图片 imageview
        for (int i = 0;i<[_array_scroll count];i++)
        {
            UIImageView *imageViewCon = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width * i) + frame.size.width, 0, frame.size.width, frame.size.height)];
            [SKUIUtils didLoadImageNotCached:[_array_scroll objectAtIndex:i] inImageView:imageViewCon];
            [_scrollView_body addSubview:imageViewCon];
        }
        /// 取数组最后一张图片 放在第0页
        UIImageView *imageView_begin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_array_scroll objectAtIndex:([_array_scroll count]-1)]]];
        imageView_begin.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        /// 添加最后1页在首页 循环
        [_scrollView_body addSubview:imageView_begin];
        
        
        /// 取数组第一张图片 放在最后1页
        UIImageView *imageView = [[UIImageView alloc] init];
        [SKUIUtils didLoadImageNotCached:[_array_scroll objectAtIndex:0] inImageView:imageView];
        ///添加第1页在最后 循环
        imageView.frame = CGRectMake((frame.size.width * ([_array_scroll count] + 1)) , 0, frame.size.width, frame.size.height);
        [_scrollView_body addSubview:imageView];
         /// +上第1页和第4页  原理：4-[1-2-3-4]-1
        [_scrollView_body setContentSize:CGSizeMake(frame.size.width * ([_array_scroll count] + 2), frame.size.height)];
        [_scrollView_body setContentOffset:CGPointMake(0, 0)];
        [_scrollView_body scrollRectToVisible:CGRectMake(frame.size.width,0,frame.size.width,frame.size.height) animated:NO];
    }
    return self;
}

#pragma mark - scrollview委托函数 -
/**
 scrollview委托函数
 **/
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = _scrollView_body.frame.size.width;
    int page = floor((_scrollView_body.contentOffset.x - pagewidth/([_array_scroll count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    _pageControl_scroll.currentPage = page;
}

/**
 scrollview 委托函数
 **/
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = _scrollView_body.frame.size.width;
    int currentPage = floor((_scrollView_body.contentOffset.x - pagewidth/ ([_array_scroll count]+2)) / pagewidth) + 1;

    if (currentPage == 0)
    {
        [_scrollView_body scrollRectToVisible:CGRectMake(scrollView.frame.size.width * [_array_scroll count],0,scrollView.frame.size.width,scrollView.frame.size.height) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage == ([_array_scroll count]+1))
    {
        [_scrollView_body scrollRectToVisible:CGRectMake(scrollView.frame.size.width,0,scrollView.frame.size.width,scrollView.frame.size.height) animated:NO];
    }
}

/**
 定时器绑定的方法
 **/
- (void)runTimePage
{
    NSInteger page = _pageControl_scroll.currentPage;
    page++;
    page = page > 3 ? 0 : page ;
    [_scrollView_body scrollRectToVisible:CGRectMake(_scrollView_body.frame.size.width*(page+1),0,_scrollView_body.frame.size.width,_scrollView_body.frame.size.height) animated:YES];
}


@end
