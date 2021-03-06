//
//  TQQPlatform.h
//  Trochilus
//
//  Created by 王权伟 on 2017/7/11.
//  Copyright © 2017年 王权伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTypeDefine.h"

@interface TQQPlatform : NSObject

+ (instancetype) shareInstance;

/**
 判断是否安装了QQ
 
 @return YES or NO
 */
+ (BOOL)isQQInstalled;

/**
 判断是否安装了TIM
 @return YES or NO
 */
+ (BOOL)isTIMInstalled;

/**
 分享到QQ好友
 
 @param parameters QQ好友分享参数
 @param stateChangedHandler 授权状态变更回调处理
 @return 分享字符串
 */
+ (NSString *)shareToQQParameters:(NSMutableDictionary *)parameters onStateChanged:(TStateChangedHandler)stateChangedHandler;

/**
 分享到QQ空间
 
 @param parameters QQ空间分享参数
 @param stateChangedHandler 授权状态变更回调处理
 @return 分享字符串
 */
+ (NSString *)shareToQZoneParameters:(NSMutableDictionary *)parameters onStateChanged:(TStateChangedHandler)stateChangedHandler;

/**
 *  分享平台授权
 *
 *  @param settings    授权设置,目前只接受TAuthSettingKeyScopes属性设置，如新浪微博关注官方微博：@{TAuthSettingKeyScopes : @[@"follow_app_official_microblog"]}，类似“follow_app_official_microblog”这些字段是各个社交平台提供的。
 *   Scopes:http://wiki.open.qq.com/wiki/%E3%80%90QQ%E7%99%BB%E5%BD%95%E3%80%91API%E6%96%87%E6%A1%A3
 *  @param stateChangedHandler 授权状态变更回调处理
 */
+ (NSMutableString *)authorizeToQQPlatformSettings:(NSDictionary *)settings
                                    onStateChanged:(TAuthorizeStateChangedHandler)stateChangedHandler;


/**
 QQ客户端回调
 @param url 回调Url
 @return YES or NO
 */
+ (BOOL)handleUrlWithQQ:(NSURL *)url;

@end
