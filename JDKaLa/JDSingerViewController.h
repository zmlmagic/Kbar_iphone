//
//  JDSingerViewController.h
//  JDKaLa
//
//  Created by zhangminglei on 11/7/13.
//  Copyright (c) 2013 张明磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDSingerViewController : UIViewController

@property (nonatomic, weak) UINavigationController *navigationController_return;

@property (nonatomic, assign) BOOL bool_search;

- (id)initWithNavigationController:(UINavigationController *)navigationController;

@end
