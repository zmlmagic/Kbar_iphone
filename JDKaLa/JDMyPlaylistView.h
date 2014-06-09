//
//  JDMyPlaylistView.h
//  JDKaLa
//
//  Created by 韩 抗 on 13-11-15.
//  Copyright (c) 2013年 张明磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDSongs;

@interface JDMyPlaylistView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) NSMutableArray *array_data;
@property (assign, nonatomic) BOOL bool_buySong;
@property (retain, nonatomic) SDSongs *song_buy;
@property (retain, nonatomic) UITableViewCell *selectCell;
@property (assign, nonatomic) BOOL bool_local;
@property (assign, nonatomic) NSIndexPath *delectCellId;


@property (assign, nonatomic) UINavigationController *navigationController_return;

@end
