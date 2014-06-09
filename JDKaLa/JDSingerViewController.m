//
//  JDSingerViewController.m
//  JDKaLa
//
//  Created by zhangminglei on 11/7/13.
//  Copyright (c) 2013 张明磊. All rights reserved.
//

#import "JDSingerViewController.h"
#import "SKUIUtils.h"


@interface JDSingerViewController ()

@end

@implementation JDSingerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor redColor]];
        // Custom initialization
    }
    return self;
}

- (id)initWithNavigationController:(UINavigationController *)navigationController
{
    self = [super init];
    if (self)
    {
        IOS7_STATEBAR;
        _navigationController_return = navigationController;
        if(!IOS7_VERSION)
        {
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [backButton setFrame:CGRectMake(0, 0, 70, 35)];
            [backButton addTarget:self action:@selector(didClickButtonTitleBack) forControlEvents:UIControlEventTouchUpInside];
            [SKUIUtils didLoadImageNotCached:@"titleBack.png" inButton:backButton withState:UIControlStateNormal];
            [self.view addSubview:backButton];
           
        }
        
        UIImageView *imageView_search = (UIImageView *)[_navigationController_return.navigationBar viewWithTag:200];
        [imageView_search setFrame:CGRectMake(imageView_search.frame.origin.x + 60, imageView_search.frame.origin.y, imageView_search.frame.size.width - 60, imageView_search.frame.size.height)];
        [SKUIUtils didLoadImageNotCached:@"bg_search_short.png" inImageView:imageView_search];
        
        UITextField *textField_search = (UITextField *)[_navigationController_return.navigationBar viewWithTag:201];
        [textField_search setFrame:CGRectMake(textField_search.frame.origin.x + 60, textField_search.frame.origin.y, textField_search.frame.size.width - 60, textField_search.frame.size.height)];
    }
    return self;
}

#pragma mark - 状态栏控制 -
/**状态栏控制**/
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleBlackTranslucent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    UIImageView *imageView_search = (UIImageView *)[_navigationController_return.navigationBar viewWithTag:200];
    [imageView_search setFrame:CGRectMake(imageView_search.frame.origin.x - 60, imageView_search.frame.origin.y, imageView_search.frame.size.width + 60, imageView_search.frame.size.height)];
    [SKUIUtils didLoadImageNotCached:@"bg_search_long.png" inImageView:imageView_search];
    
    UITextField *textField_search = (UITextField *)[_navigationController_return.navigationBar viewWithTag:201];
    [textField_search setFrame:CGRectMake(textField_search.frame.origin.x - 60, textField_search.frame.origin.y, textField_search.frame.size.width + 60, textField_search.frame.size.height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 返回按钮回调
 **/
- (void)didClickButtonTitleBack
{
    [_navigationController_return popViewControllerAnimated:YES];
}

@end
