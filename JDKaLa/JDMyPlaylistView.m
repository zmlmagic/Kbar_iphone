//
//  JDMyPlaylistView.m
//  JDKaLa
//
//  Created by 韩 抗 on 13-11-15.
//  Copyright (c) 2013年 张明磊. All rights reserved.
//

#import "JDMyPlaylistView.h"
#import "JDSqlDataBase.h"
#import "UIUtils.h"
#import "ClientAgent.h"
#import "JDModel_userInfo.h"

typedef enum
{
    JDCellButtonTag_songName         = 10,
    JDCellButtonTag_singerName           ,
    JDCellButtonTag_background           ,
    JDCellButtonTag_pay                  ,
    JDCellButtonTag_play                 ,
    JDCellButtonTag_list                 ,
    JDCellButtonTag_favorite             ,
}JDCellButtonTag;

typedef enum
{
    JDButtonBuyTag_buySong         = 50,
    JDButtonBuyTag_useCard             ,
    JDButtonBuyTag_back                ,
}JDButtonBuyTag;

typedef enum
{
    JDPayTag_30min            = 200,
    JDPayTag_1hour                 ,
    JDPayTag_2hour                 ,
    JDPayTag_month                 ,
}
JDPayTag;


@implementation JDMyPlaylistView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)configureView_tableView
{
    JDSqlDataBase *base = [[JDSqlDataBase alloc] init];
    self.array_data = [base reciveSongArrayWithTag:2];
    //[base selectSongandChangeItTagWithArray:_array_data];
    if([_array_data count] != 0)
    {
        UITableView *tableView_songShow = [[UITableView alloc] initWithFrame:CGRectMake(0, 7, 1024, 691)];
        [tableView_songShow setTag:800];
        [tableView_songShow setBackgroundColor:[UIColor clearColor]];
        [tableView_songShow setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [tableView_songShow setDataSource:self];
        [tableView_songShow setDelegate:self];
        [self addSubview:tableView_songShow];
    }
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_array_data count];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SingerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        [self installCell:cell withIndex:indexPath.row];
    }
    SDSongs *song = [_array_data objectAtIndex:indexPath.row];
    [self installCell:cell withSong:song];
    return cell;
}

- (void)installCell:(UITableViewCell *)cell withIndex:(NSInteger)index
{
    UIButton *button_background = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_background setFrame:CGRectMake(20, 5, 956, 75)];
    [UIUtils didLoadImageNotCached:@"songs_bar_bg.png" inButton:button_background withState:UIControlStateNormal];
    [button_background setTag:JDCellButtonTag_background];
    [button_background addTarget:self action:@selector(didClickButton_cell:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:button_background];
    
    UILabel *label_songName = [[UILabel alloc] initWithFrame:CGRectMake(120, 14, 430, 45)];
    [label_songName setBackgroundColor:[UIColor clearColor]];
    [label_songName setFont:[UIFont systemFontOfSize:25.0]];
    [label_songName setTextColor:[UIColor whiteColor]];
    [label_songName setTag:JDCellButtonTag_songName];
    [button_background addSubview:label_songName];
    
    UIImageView *imageView_pay = [[UIImageView alloc] initWithFrame:CGRectMake(20, 26, 62, 22)];
    [imageView_pay setTag:JDCellButtonTag_pay];
    [button_background addSubview:imageView_pay];
    
    UILabel *label_singer = [[UILabel alloc] initWithFrame:CGRectMake(530, 14, 120, 45)];
    [label_singer setBackgroundColor:[UIColor clearColor]];
    [label_singer setTextColor:[UIColor whiteColor]];
    [label_singer setTag:JDCellButtonTag_singerName];
    [label_singer setFont:[UIFont systemFontOfSize:25.0f]];
    [button_background addSubview:label_singer];
  
    UIButton *button_play = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_play setFrame:CGRectMake(725, 10, 50, 50)];
    [UIUtils didLoadImageNotCached:@"songs_bar_btn_play.png" inButton:button_play withState:UIControlStateNormal];
    [button_play setTag:JDCellButtonTag_play];
    [button_play addTarget:self action:@selector(didClickButton_cell:) forControlEvents:UIControlEventTouchUpInside];
    [button_background addSubview:button_play];
    
    UIButton *button_list = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_list setFrame:CGRectMake(875, 14, 45, 45)];
    [UIUtils didLoadImageNotCached:@"player_list_thumbnail_btn_delete.png" inButton:button_list withState:UIControlStateNormal];
    [button_list setTag:JDCellButtonTag_list];
    [button_list addTarget:self action:@selector(didClickButton_cell:) forControlEvents:UIControlEventTouchUpInside];
    [button_background addSubview:button_list];
}

- (void)installCell:(UITableViewCell *)cell withSong:(SDSongs *)song
{
    UILabel *label_songName = (UILabel *)[cell viewWithTag:JDCellButtonTag_songName];
    [label_songName setText:song.songTitle];
    
    UILabel *label_singerName = (UILabel *)[cell viewWithTag:JDCellButtonTag_singerName];
    [label_singerName setText:song.songSingers];
    
    UIImageView *imageView_pay = (UIImageView *)[cell viewWithTag:JDCellButtonTag_pay];
    [UIUtils didLoadImageNotCached:nil inImageView:imageView_pay];
    
    if(song.songBuyTag == 0)
    {
        UIImageView *imageView_pay = (UIImageView *)[cell viewWithTag:JDCellButtonTag_pay];
        [UIUtils didLoadImageNotCached:nil inImageView:imageView_pay];
    }
    else
    {
        UIImageView *imageView_pay = (UIImageView *)[cell viewWithTag:JDCellButtonTag_pay];
        [UIUtils didLoadImageNotCached:@"songs_icon_paid.png" inImageView:imageView_pay];
    }
}

- (void)didClickButton_cell:(id)sender
{
    UIButton *button_singer = (UIButton *)sender;
    UITableViewCell *cell = [self reciveSuperCellWithView:button_singer];
    UITableView *tableView = [self reciveSuperTableWithView:cell];
    NSIndexPath *indexPath = [tableView indexPathForCell:cell];
    SDSongs *song = [_array_data objectAtIndex:indexPath.row];
    
    switch (button_singer.tag)
    {
        case JDCellButtonTag_background:
        {
            self.song_buy = song;
            self.selectCell = cell;
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(handleGetPermission:)
                                                         name:NOTI_GET_PERMISSION_RESULT
                                                       object:nil];
            
            ClientAgent *agent = [[ClientAgent alloc] init];
            [agent getPermission:_song_buy.songMd5 UserID:[JDModel_userInfo sharedModel].string_userID Token:[JDModel_userInfo sharedModel].string_token];
            
        }break;
            
        case JDCellButtonTag_play:
        {
            self.song_buy = song;
            self.selectCell = cell;
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(handleGetPermission:)
                                                         name:NOTI_GET_PERMISSION_RESULT
                                                       object:nil];
            
            ClientAgent *agent = [[ClientAgent alloc] init];
            [agent getPermission:_song_buy.songMd5 UserID:[JDModel_userInfo sharedModel].string_userID Token:[JDModel_userInfo sharedModel].string_token];
            
        }break;
            
        case JDCellButtonTag_list:
        {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(reloadTableView:)
                                                         name:@"JDSongStateChange_order"
                                                       object:nil];
            
            self.delectCellId = indexPath;
            JDSqlDataBase *base = [[JDSqlDataBase alloc] init];
            [base deleteSongFormLocalSingerWithString:song withTag:2];
            [UIUtils view_showProgressHUD:@"已移出播放列表" inView:self withTime:1.0f];
            
        }break;
            
        case JDCellButtonTag_favorite:
        {
            JDSqlDataBase *base = [[JDSqlDataBase alloc] init];
            [base selectSongandChangeItTag:song];
            if(song.songFavoriteTag == 1)
            {
                [UIUtils didLoadImageNotCached:@"songs_bar_btn_favor.png" inButton:button_singer withState:UIControlStateNormal];
                [base deleteSongFormLocalSingerWithString:song withTag:1];
                [UIUtils view_showProgressHUD:@"已移出收藏列表" inView:self withTime:1.0f];
                
            }
            else
            {
                song.songFavoriteTag = 1;
                if([base saveSong:song withTag:1])
                {
                    [UIUtils didLoadImageNotCached:@"songs_bar_btn_favor_added.png" inButton:button_singer withState:UIControlStateNormal];
                    [UIUtils view_showProgressHUD:@"已添加至收藏列表" inView:self withTime:1.0f];
                }
            }
            
        }break;
        default:
            break;
    }
}

- (UITableViewCell *)reciveSuperCellWithView:(UIView *)view
{
    for (UIView *next = [view superview]; next; next = next.superview)
    {
        if ([next isKindOfClass:[UITableViewCell class]])
        {
            return (UITableViewCell *)next;
        }
    }
    return nil;
}

- (UITableView *)reciveSuperTableWithView:(UIView *)view
{
    for (UIView *next = [view superview]; next; next = next.superview)
    {
        if ([next isKindOfClass:[UITableView class]])
        {
            return (UITableView *)next;
        }
    }
    return nil;
}

- (UIView *)reciveSuperViewWithButton:(UIButton *)button
{
    for (UIView *next = [button superview]; next; next = next.superview)
    {
        if ([next isKindOfClass:[UIView class]])
        {
            return (UIView *)next;
        }
    }
    return nil;
}

- (UIView *)reciveSuperViewWithView:(UIView *)view
{
    for (UIView *next = [view superview]; next; next = next.superview)
    {
        if ([next isKindOfClass:[UIView class]])
        {
            return (UIView *)next;
        }
    }
    return nil;
}

- (UIViewController *)reciveSuperViewControllerWithView:(UIView *)view
{
    for (UIView *next = [view superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - 播放前鉴权回调 -
/**
 * 播放前鉴权回调
 */
- (void)handleGetPermission:(NSNotification *)note
{
    NSDictionary    *state = (NSMutableDictionary*)note.userInfo;
    int             resultCode = [[state objectForKey:@"result"] intValue];
    
    if([[state objectForKey:@"result"] length] > 0 && 0 == resultCode)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:NOTI_GET_PERMISSION_RESULT
                                                      object:nil];
        
        //JDMoviePlayerViewController *movePlayer = [[JDMoviePlayerViewController alloc] initWithSong:_song_buy];
        //[movePlayer setBool_isHistoryOrSearchSong:YES];
        //[movePlayer.view_alreadySong setBool_currentAlready:NO];
        //movePlayer.navigationController_return = _navigationController_return;
        //[_navigationController_return pushViewController:movePlayer animated:YES];
        //[movePlayer playBegin];
        //[movePlayer release];
        
    }
    else
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:NOTI_GET_PERMISSION_RESULT
                                                      object:nil];
        /*
         [self performSelectorInBackground:@selector(reloadKB) withObject:nil];
         [self installView_payView];*/
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
