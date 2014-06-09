//
//  JDModel_userInfo.m
//  JDKaLa
//
//  Created by zhangminglei on 6/27/13.
//  Copyright (c) 2013 zhangminglei. All rights reserved.
//

#import "JDModel_userInfo.h"
//#import "UIUtils.h"

@implementation JDModel_userInfo

static JDModel_userInfo *shareJDModel_userInfo = nil;

+ (JDModel_userInfo *)sharedModel
{
    @synchronized(self)
    {
        if(shareJDModel_userInfo == nil)
        {
            shareJDModel_userInfo = [[self alloc] init] ;
        }
    }
    return shareJDModel_userInfo;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (shareJDModel_userInfo == nil)
        {
            shareJDModel_userInfo = [super allocWithZone:zone];
            return shareJDModel_userInfo;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone*)zone
{
    return self;
}


- (void)configureDataWithUser
{
    _bool_hasMaster = YES;
    _bool_homeBack = NO;
    _string_tourist = NO;
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"])
    {
        _string_userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    }
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"])
    {
        _string_userPass = [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
    }
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"])
    {
        _string_nickName = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"money"])
    {
        _string_money = [[NSUserDefaults standardUserDefaults] objectForKey:@"money"];
    }
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"device"])
    {
        _string_device = [[NSUserDefaults standardUserDefaults] objectForKey:@"device"];
    }
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"portrait"])
    {
        _string_portrait = [[NSUserDefaults standardUserDefaults] objectForKey:@"portrait"];
    }
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"token"])
    {
        _string_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    }
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"signature"])
    {
        _string_signature = [[NSUserDefaults standardUserDefaults] objectForKey:@"signature"];
    }
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"userID"])
    {
        _string_userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    }
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"sex"])
    {
        _integer_sex = [[NSUserDefaults standardUserDefaults] integerForKey:@"sex"];
    }
}

- (void)configureDataWithTourist
{
    _bool_hasMaster = YES;
    _bool_homeBack = NO;
    _string_tourist = NO;
}

@end
