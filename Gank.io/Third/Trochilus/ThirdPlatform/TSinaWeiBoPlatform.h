//
//  TSinaWeiBoPlatform.h
//  Trochilus
//
//  Created by 王权伟 on 2017/7/11.
//  Copyright © 2017年 王权伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTypeDefine.h"

@interface TSinaWeiBoPlatform : NSObject

+(instancetype) shareInstance;

/**
 判断是否安装了微博
 
 @return YES or NO
 */
+(BOOL)isSinaWeiBoInstalled;


/**
 微博分享
 
 @param parameters 分享参数
 @param stateChangedHandler 授权状态变更回调处理
 @return 分享字符串
 */
+ (NSString *)shareToSinaWeiBoParameters:(NSMutableDictionary *)parameters onStateChanged:(TStateChangedHandler)stateChangedHandler;

/**
 新浪微博授权
 @param settings 授权设置,目前只接受TAuthSettingKeyScopes属性设置，如新浪微博关注官方微博：@{TAuthSettingKeyScopes : @[@"follow_app_official_microblog"]}，类似“follow_app_official_microblog”这些字段是各个社交平台提供的。暂未实现
 @param stateChangedHandler 授权状态变更回调处理
 @return 构造好的授权字符串
 */
+ (NSMutableString *)authorizeToSinaWeiBoPlatformSettings:(NSDictionary *)settings
                                           onStateChanged:(TAuthorizeStateChangedHandler)stateChangedHandler;

/**
 取消授权
 */
+ (void)unAurhAct;

/**
 新浪微博客户端回调
 
 @param url 回调Url
 @return YES or NO
 */
+ (BOOL)handleUrlWithSinaWeiBo:(NSURL *)url;

@end
