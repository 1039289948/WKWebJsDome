//
//  NSUserDefaultsKeys.h
//  TestProjectDome
//
//  Created by Mobiyun on 2017/7/3.
//  Copyright © 2017年 Mobiyun. All rights reserved.
//

#ifndef NSUserDefaultsKeys_h
#define NSUserDefaultsKeys_h


#define DOWN_VERSION_JSON @"" //版本更新检测
#define DOWN_HTML_URL @""  //下载最新h5压缩包



/** userDefaults */
#define M_USERDEFAULTS                 ([NSUserDefaults standardUserDefaults])
#define M_USERDEFAULTS_GET(key)        ([[NSUserDefaults standardUserDefaults] objectForKey:key])
#define M_USERDEFAULTS_SET(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];\
[M_USERDEFAULTS synchronize];

/**
 无网络弹框

 @return 网络连接失败！请检查网络设置
 */
#define ALERT_ERROR_MESSAGE_NO_NETWORK @"网络连接失败！请检查网络设置"

/**
 登录过期

 @return login_required
 */
#define LOGIN_REQUIRED @"login_required"

/**
 网络请求 设置cookie

 @return Set-Cookie
 */
#define HTTP_SET_COOKIE @"Set_Cookie"


/**
 网络状态

 @return netWorkStatus
 */
#define NET_WORK_STATUS @"netWorkStatus"

/**
 网络类型

 @return netWorkType
 */
#define NET_WORK_TYPE @"netWorkType"

/**
 七牛上传图片token

 @return QinNiu_Token
 */
#define QINNIU_TOKEN @"qin_niu_token"


/**
 七牛有效凭证

 @return qin_niu_token_required
 */
#define QINNIU_TOKEN_TIMER @"qin_niu_token_timer"

/**
 发票提交白名单

 @return white_list
 */
#define WHITE_LIST @"white_list"

/**
 本地HTML版本

 @return 本地HTML版本
 */
#define HTML_VERSION @"appVerHtml"

/**
 本地HTML路径

 @return 本地HTML路径
 */
#define WEB_VIEW_URL @"WEB_VIEW_URL"




#endif /* NSUserDefaultsKeys_h */
