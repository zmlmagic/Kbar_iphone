//
//  JDRequestSongVIew.m
//  JDKaLa
//
//  Created by zhangminglei on 11/13/13.
//  Copyright (c) 2013 张明磊. All rights reserved.
//

#import "JDRequestSongView.h"
#import "JDScrollView.h"
#import "SKUIUtils.h"
#import "JDSingerViewController.h"

@implementation JDRequestSongView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //[self setBackgroundColor:[UIColor redColor]];
        JDScrollView *view_scroll = [[JDScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        [self addSubview:view_scroll];
        
        UITableView *tableView_body = [[UITableView alloc] initWithFrame:CGRectMake(0, view_scroll.frame.origin.y + view_scroll.frame.size.height, self.frame.size.width, self.frame.size.height - view_scroll.frame.size.height) style:UITableViewStylePlain];
        [tableView_body setBackgroundColor:[UIColor clearColor]];
        [tableView_body setDataSource:self];
        [tableView_body setDelegate:self];
        [tableView_body setSeparatorColor:[UIColor whiteColor]];
        [self addSubview:tableView_body];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"bodyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self installCell:cell withIndex:indexPath.row];
    }
    [self configureContentCell:cell withIndex:indexPath.row];
    return cell;
}

- (void)installCell:(UITableViewCell *)cell withIndex:(NSInteger)index
{
    UIImageView *imageView_detail = [[UIImageView alloc] initWithFrame:CGRectMake(275, 17, 12, 20)];
    [SKUIUtils didLoadImageNotCached:@"cell_detail.png" inImageView:imageView_detail];
    [cell addSubview:imageView_detail];
    
    UIImageView *imageViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
    [imageViewHead setTag:10];
    [cell addSubview:imageViewHead];
    
    UILabel *lable_title = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 200, 30)];
    [lable_title setTag:11];
    [lable_title setBackgroundColor:[UIColor clearColor]];
    [lable_title setTextColor:[UIColor colorWithWhite:0.2 alpha:1.0]];
    [lable_title setFont:[UIFont systemFontOfSize:14.0f]];
    [cell addSubview:lable_title];
}

- (void)configureContentCell:(UITableViewCell *)cell withIndex:(NSInteger)index
{
    UIImageView *imageView_tmp = (UIImageView *)[cell viewWithTag:10];
    UILabel *label_tmp = (UILabel *)[cell viewWithTag:11];
    
    switch (index)
    {
        case 0:
        {
            [SKUIUtils didLoadImageNotCached:@"table_one.png" inImageView:imageView_tmp];
            [label_tmp setText:@"歌手分类"];
            
        }break;
        case 1:
        {
            [SKUIUtils didLoadImageNotCached:@"table_two.png" inImageView:imageView_tmp];
            [label_tmp setText:@"歌曲分类"];
            
        }break;
        case 2:
        {
            [SKUIUtils didLoadImageNotCached:@"table_three.png" inImageView:imageView_tmp];
            [label_tmp setText:@"演唱手机里的歌曲"];
            
        }break;
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(iPhone5)
    {
        return 60.0f;
    }
    else
    {
        return 56.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDSingerViewController *singerViewController = [[JDSingerViewController alloc] initWithNavigationController:_navigationController_return];
    [_navigationController_return pushViewController:singerViewController animated:YES];
}


@end
