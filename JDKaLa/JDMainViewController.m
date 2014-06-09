//
//  JDMainViewController.m
//  JDKaLa
//
//  Created by zhangminglei on 11/7/13.
//  Copyright (c) 2013 张明磊. All rights reserved.
//

#import "JDMainViewController.h"
#import "SKUIUtils.h"
#import "JDRequestSongView.h"
#import "JDMyPlaylistView.h"
#import "JDTabBarView.h"

@interface JDMainViewController ()

@end

@implementation JDMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        IOS7_STATEBAR;
        UIImageView *imageView_background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [SKUIUtils didLoadImageNotCached:@"background.png" inImageView:imageView_background];
        [self.view addSubview:imageView_background];
        [self.view setBackgroundColor:[UIColor blackColor]];
        [self installViewTitle];
        [self installViewSegmentController];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)installViewTitle
{
    if(IOS7_VERSION)
    {
        UIImageView *imageView_search = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 300, 29)];
        [imageView_search setTag:200];
        [SKUIUtils didLoadImageNotCached:@"bg_search_long.png" inImageView:imageView_search];
        [self.view addSubview:imageView_search];
        
        UITextField *textfield_search = [[UITextField alloc] initWithFrame:CGRectMake(50, 25, 250, 30)];
        [textfield_search setTag:201];
        //[textfield_search setPlaceholder:@"请输入歌曲名或歌曲名"];
        [textfield_search setTextColor:[UIColor whiteColor]];
        [textfield_search setBackgroundColor:[UIColor clearColor]];
        textfield_search.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textfield_search.returnKeyType = UIReturnKeySearch;
        textfield_search.autocorrectionType = UITextAutocorrectionTypeNo;
        [textfield_search setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self.view addSubview:textfield_search];
    }
    else
    {
        UIImageView *imageView_search = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 29)];
        [imageView_search setTag:200];
        [SKUIUtils didLoadImageNotCached:@"bg_search_long.png" inImageView:imageView_search];
        [self.view addSubview:imageView_search];
        
        UITextField *textfield_search = [[UITextField alloc] initWithFrame:CGRectMake(50, 12, 250, 30)];
        textfield_search.autocapitalizationType = UITextAutocapitalizationTypeNone;
        //[textfield_search setPlaceholder:@"请输入歌曲名或歌曲名"];
        [textfield_search setTextColor:[UIColor whiteColor]];
        [textfield_search setTag:201];
        textfield_search.returnKeyType = UIReturnKeySearch;
        textfield_search.autocorrectionType = UITextAutocorrectionTypeNo;
        [textfield_search setFont:[UIFont systemFontOfSize:20]];
        [textfield_search setBackgroundColor:[UIColor clearColor]];
        [textfield_search setClearButtonMode:UITextFieldViewModeAlways];
        [self.view addSubview:textfield_search];
    }
}

- (void)installViewSegmentController
{
    _int_before = 0;
    _int_before = 0;
    
    UIButton *button_one = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_one setFrame:CGRectMake(20, 42, 60, 50)];
    [SKUIUtils didLoadImageNotCached:@"icon_more_ds.png" inButton:button_one withState:UIControlStateNormal];
    [SKUIUtils didLoadImageNotCached:@"icon_more_d.png" inButton:button_one withState:UIControlStateHighlighted];
    [button_one addTarget:self action:@selector(didClickButton_segment:) forControlEvents:UIControlEventTouchUpInside];
    [button_one setTag:101];
    [self.view addSubview:button_one];
    
    UIButton *button_two = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_two setFrame:CGRectMake(130, 42, 60, 50)];
    [SKUIUtils didLoadImageNotCached:@"icon_more_y.png" inButton:button_two withState:UIControlStateNormal];
    [SKUIUtils didLoadImageNotCached:@"icon_more_ys.png" inButton:button_two withState:UIControlStateHighlighted];
    [button_two addTarget:self action:@selector(didClickButton_segment:) forControlEvents:UIControlEventTouchUpInside];
    [button_two setTag:102];
    [self.view addSubview:button_two];
    
    UIButton *button_three = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_three setFrame:CGRectMake(240, 42, 60, 50)];
    [SKUIUtils didLoadImageNotCached:@"icon_more_w.png" inButton:button_three withState:UIControlStateNormal];
    [SKUIUtils didLoadImageNotCached:@"icon_more_ws.png" inButton:button_three withState:UIControlStateHighlighted];
    [button_three addTarget:self action:@selector(didClickButton_segment:) forControlEvents:UIControlEventTouchUpInside];
    [button_three setTag:103];
    [self.view addSubview:button_three];
    
    IOS7(button_one);
    IOS7(button_two);
    IOS7(button_three);
}

/**
 点击分选栏
 **/
- (void)didClickButton_segment:(id)sender
{
    //UIButton *button_segment = (UIButton *)sender;
}

- (void)installViewBody
{
    JDRequestSongView *view_requestSong = [[JDRequestSongView alloc] initWithFrame:CGRectMake(0, 95, 320, [UIScreen mainScreen].currentMode.size.height - 141)];
    [view_requestSong setNavigationController_return:_navigationController_return];
    IOS7(view_requestSong);
    [self.view addSubview:view_requestSong];
    
    JDTabBarView *tabBar = [[JDTabBarView alloc] init];
    IOS7(tabBar);
    [self.view addSubview:tabBar];
    
    /*
    JDMyPlaylistView *view_myPlaylist = [[JDMyPlaylistView alloc] initWithFrame:CGRectMake(0, 95, 320, [UIScreen mainScreen].currentMode.size.height - 141)];
    [view_myPlaylist setNavigationController_return:_navigationController_return];
    IOS7(view_myPlaylist);
    [self.view addSubview:view_myPlaylist];
    
    JDTabBarView *tabBar = [[JDTabBarView alloc] init];
    IOS7(tabBar);
    [self.view addSubview:tabBar];
    */
}


@end
