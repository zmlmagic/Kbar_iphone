//
//  JDMainViewController.h
//  JDKaLa
//
//  Created by zhangminglei on 11/7/13.
//  Copyright (c) 2013 张明磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDMainViewController : UIViewController

@property (nonatomic, weak) UINavigationController *navigationController_return;

@property (assign, nonatomic) NSInteger *int_now;
@property (assign, nonatomic) NSInteger *int_before;
@property (assign, nonatomic) UIView *view_body;

- (void)installViewBody;

@end
