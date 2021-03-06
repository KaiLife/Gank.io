//
//  NSMutableDictionary+Share.m
//  Trochilus
//
//  Created by 王权伟 on 2017/7/11.
//  Copyright © 2017年 王权伟. All rights reserved.
//

#import "NSMutableDictionary+TrochilusShare.h"
#import <UIKit/UIKit.h>

@implementation NSMutableDictionary (TrochilusShare)
#pragma mark- 通用分享参数
/**
 *  设置分享参数
 *
 *  @param text     文本
 *  @param images   图片集合,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、TImage。如: @"http://www.mob.com/images/logo_black.png" 或 @[@"http://www.mob.com/images/logo_black.png"]
 *  @param url      网页路径/应用路径
 *  @param title    标题
 *  @param type     分享类型
 */
- (void)TSetupShareParamsByText:(NSString *)text
                         images:(id)images
                            url:(NSURL *)url
                          title:(NSString *)title
                           type:(TContentType)type {
    
    //文本
    if (text) {
        [self setObject:text forKey:@"Text"];
    }
    
    //图片
    if (images) {
        [self setObject:images forKey:@"Images"];
    }
    
    //网页路径/应用路径
    if (url) {
        [self setObject:url forKey:@"URL"];
    }
    
    //标题
    if (title) {
        [self setObject:title forKey:@"Title"];
    }
    
    //分享类型
    if (type) {
        [self setObject:@(type) forKey:@"Type"];
    }
    
}

#pragma mark- QQ
/**
 *  设置QQ分享参数
 *
 *  @param text            分享内容
 *  @param title           分享标题
 *  @param url             分享链接(如果分享类型为音频/视频时,应该传入音频/视频的网络URL地址)
 [特别说明:分享视频到QZone时,视频为网络视频,请传入视频网络URL地址;视频为本地视频的,请传入来源于手机系统相册的相关的Asset URL地址]
 *  @param audioFlashURL   分享音频时缩略图播放源,仅平台子类型为TPlatformSubTypeQQFriend,且分享类型为Audio时生效
 *  @param videoFlashURL   分享视频时缩略图播放源,仅平台子类型为TPlatformSubTypeQQFriend,且分享类型为Video时生效
 *  @param thumbImage      缩略图，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、TImage
 *  @param images          图片集合,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、TImage
 QQ会采用首张图片，QZone则支持图片数组
 *  @param type            分享类型, 仅支持Text、Image、WebPage、Audio、Video类型
 *  @param platformSubType 平台子类型，只能传入TPlatformSubTypeQZone或者TPlatformSubTypeQQFriend其中一个
 */
- (void)TSetupQQParamsByText:(NSString *)text
                       title:(NSString *)title
                         url:(NSURL *)url
               audioFlashURL:(NSURL *)audioFlashURL
               videoFlashURL:(NSURL *)videoFlashURL
                  thumbImage:(id)thumbImage
                      images:(id)images
                        type:(TContentType)type
          forPlatformSubType:(TPlatformType)platformSubType {
    
    //文本
    if (text) {
        [self setObject:text forKey:@"Text"];
    }
    
    //标题
    if (title) {
        [self setObject:title forKey:@"Title"];
    }
    
    //分享链接(如果分享类型为音频/视频时,应该传入音频/视频的网络URL地址)
    //[特别说明:分享视频到QZone时,视频为网络视频,请传入视频网络URL地址;视频为本地视频的,请传入来源于手机系统相册的相关的Asset URL地址]
    if (url) {
        [self setObject:url forKey:@"URL"];
    }
    
    //分享音频时缩略图播放源,仅平台子类型为TPlatformSubTypeQQFriend,且分享类型为Audio时生效
    if (audioFlashURL && platformSubType == TPlatformSubTypeQQFriend && type == TContentTypeAudio) {
        [self setObject:audioFlashURL forKey:@"AudioFlashURL"];
    }
    
    //分享视频时缩略图播放源,仅平台子类型为TPlatformSubTypeQQFriend,且分享类型为Video时生效
    if (videoFlashURL && platformSubType == TPlatformSubTypeQQFriend && type == TContentTypeVideo) {
        [self setObject:videoFlashURL forKey:@"VideoFlashURL"];
    }
    
    //缩略图，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、TImage
    if (thumbImage) {
        [self setObject:thumbImage forKey:@"ThumbImage"];
    }
    
    //图片集合,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、TImageQQ会采用首张图片，QZone则支持图片数组
    if (images) {
        [self setObject:images forKey:@"Images"];
    }
    
    //分享类型, 仅支持Text、Image、WebPage、Audio、Video类型
    if (type) {
        [self setObject:@(type) forKey:@"Type"];
    }
    
    //平台子类型，只能传入TPlatformSubTypeQZone或者TPlatformSubTypeQQFriend其中一个
    if (platformSubType) {
        [self setObject:@(platformSubType) forKey:@"PlatformSubType"];
    }
    
    
}
#pragma mark- QZone
/**
 *  设置QQ分享参数
 *
 *  @param text            分享内容
 *  @param title           分享标题
 *  @param url             分享链接(如果分享类型为音频/视频时,应该传入音频/视频的网络URL地址)
 [特别说明:分享视频到QZone时,视频为网络视频,请传入视频网络URL地址;视频为本地视频的,请传入来源于手机系统相册的相关的Asset URL地址]
 *  @param audioFlashURL   分享音频时缩略图播放源,仅平台子类型为TPlatformSubTypeQQFriend,且分享类型为Audio时生效
 *  @param videoFlashURL   分享视频时缩略图播放源,仅平台子类型为TPlatformSubTypeQQFriend,且分享类型为Video时生效
 *  @param thumbImage      缩略图，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、TImage
 *  @param images          图片集合,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、TImage
 QQ会采用首张图片，QZone则支持图片数组
 *  @param type            分享类型, 仅支持Text、Image、WebPage、Audio、Video类型
 *  @param platformSubType 平台子类型，只能传入TPlatformSubTypeQZone或者TPlatformSubTypeQQFriend其中一个
 */
- (void)TSetupQZoneParamsByText:(NSString *)text
                          title:(NSString *)title
                            url:(NSURL *)url
                  audioFlashURL:(NSURL *)audioFlashURL
                  videoFlashURL:(NSURL *)videoFlashURL
                     thumbImage:(id)thumbImage
                         images:(id)images
                           type:(TContentType)type
             forPlatformSubType:(TPlatformType)platformSubType {
    
    //文本
    if (text) {
        [self setObject:text forKey:@"Text"];
    }
    
    //标题
    if (title) {
        [self setObject:title forKey:@"Title"];
    }
    
    //分享链接(如果分享类型为音频/视频时,应该传入音频/视频的网络URL地址)
    //[特别说明:分享视频到QZone时,视频为网络视频,请传入视频网络URL地址;视频为本地视频的,请传入来源于手机系统相册的相关的Asset URL地址]
    if (url) {
        [self setObject:url forKey:@"URL"];
    }
    
    //分享音频时缩略图播放源,仅平台子类型为TPlatformSubTypeQQFriend,且分享类型为Audio时生效
    if (audioFlashURL && platformSubType == TPlatformSubTypeQQFriend && type == TContentTypeAudio) {
        [self setObject:audioFlashURL forKey:@"AudioFlashURL"];
    }
    
    //分享视频时缩略图播放源,仅平台子类型为TPlatformSubTypeQQFriend,且分享类型为Video时生效
    if (videoFlashURL && platformSubType == TPlatformSubTypeQQFriend && type == TContentTypeVideo) {
        [self setObject:videoFlashURL forKey:@"VideoFlashURL"];
    }
    
    //缩略图，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、TImage
    if (thumbImage) {
        [self setObject:thumbImage forKey:@"ThumbImage"];
    }
    
    //图片集合,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、TImageQQ会采用首张图片，QZone则支持图片数组
    if (images) {
        [self setObject:images forKey:@"Images"];
    }
    
    //分享类型, 仅支持Text、Image、WebPage、Audio、Video类型
    if (type) {
        [self setObject:@(type) forKey:@"Type"];
    }
    
    //平台子类型，只能传入TPlatformSubTypeQZone或者TPlatformSubTypeQQFriend其中一个
    if (platformSubType) {
        [self setObject:@(platformSubType) forKey:@"PlatformSubType"];
    }
    
    
}

#pragma mark 微信分享参数
/**
 *  设置微信分享参数
 *
 *  @param text         文本
 *  @param title        标题
 *  @param url          分享链接
 *  @param thumbImage   缩略图，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、TImage
 *  @param image        图片，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、TImage
 *  @param musicFileURL 音乐文件链接地址
 *  @param extInfo      扩展信息
 *  @param fileData     文件数据，可以为NSData、UIImage、NSString、NSURL（文件路径）、TData、TImage
 *  @param emoticonData 表情数据，可以为NSData、UIImage、NSURL（文件路径）、TData、TImage
 *  @param type         分享类型，支持TContentTypeText、TContentTypeImage、TContentTypeWebPage、TContentTypeApp、TContentTypeAudio和TContentTypeVideo
 *  @param platformSubType 平台子类型，只能传入TPlatformSubTypeWechatSession、TPlatformSubTypeWechatTimeline和TPlatformSubTypeWechatFav其中一个
 *
 *  分享文本时：
 *  设置type为TContentTypeText, 并填入text参数
 *
 *  分享图片时：
 *  设置type为TContentTypeImage, 非gif图片时：填入title和image参数，如果为gif图片则需要填写title和emoticonData参数
 *
 *  分享网页时：
 *  设置type为TContentTypeWebPage, 并设置text、title、url以及thumbImage参数，如果尚未设置thumbImage则会从image参数中读取图片并对图片进行缩放操作。
 *
 *  分享应用时：
 *  设置type为TContentTypeApp，并设置text、title、extInfo（可选）以及fileData（可选）参数。
 *
 *  分享音乐时：
 *  设置type为TContentTypeAudio，并设置text、title、url以及musicFileURL（可选）参数。
 *
 *  分享视频时：
 *  设置type为TContentTypeVideo，并设置text、title、url参数
 */
- (void)TSetupWeChatParamsByText:(NSString *)text
                           title:(NSString *)title
                             url:(NSURL *)url
                      thumbImage:(id)thumbImage
                           image:(id)image
                    musicFileURL:(NSURL *)musicFileURL
                         extInfo:(NSString *)extInfo
                        fileData:(id)fileData
                    emoticonData:(id)emoticonData
             sourceFileExtension:(NSString *)fileExtension
                  sourceFileData:(id)sourceFileData
                            type:(TContentType)type
              forPlatformSubType:(TPlatformType)platformSubType {
    
    if (text) {
        [self setObject:text forKey:@"Text"];
    }
    
    if (title) {
        [self setObject:title forKey:@"Title"];
    }
    
    if (url) {
        [self setObject:url forKey:@"URL"];
    }
    
    if (thumbImage) {
        [self setObject:thumbImage forKey:@"ThumbImage"];
    }
    
    if (image) {
        [self setObject:image forKey:@"Images"];
    }
    
    if (musicFileURL) {
        [self setObject:musicFileURL forKey:@"MusicFileURL"];
    }
    
    if (extInfo) {
        [self setObject:extInfo forKey:@"ExtInfo"];
    }
    
    if (fileData) {
        [self setObject:fileData forKey:@"FileData"];
    }
    
    if (emoticonData) {
        [self setObject:emoticonData forKey:@"EmoticonData"];
    }
    
    if (fileExtension) {
        [self setObject:fileExtension forKey:@"SourceFileExtension"];
    }
    
    if (sourceFileData) {
        [self setObject:sourceFileData forKey:@"SourceFileData"];
    }
    
    if (type) {
        [self setObject:@(type) forKey:@"Type"];
    }
    
    if (platformSubType) {
        [self setObject:@(platformSubType) forKey:@"PlatformSubType"];
    }
    
}

/**
 设置微信小程序分享
 
 @param title 标题
 @param description 详细说明
 @param webpageUrl 网址（6.5.6以下版本微信会自动转化为分享链接 必填）
 @param path 跳转到页面路径
 @param thumbImage 缩略图 （必填）
 @param userName 小程序的userName （必填）
 @param platformSubType 分享自平台 微信小程序暂只支持 TPlatformSubTypeWechatSession（微信好友分享）
 */
- (void)TSetupWeChatMiniProgramParamsByTitle:(NSString *)title
                                 description:(NSString *)description
                                  webpageUrl:(NSURL *)webpageUrl
                                        path:(NSString *)path
                                  thumbImage:(id)thumbImage
                                    userName:(NSString *)userName
                          forPlatformSubType:(TPlatformType)platformSubType {
    
    if (title) {
        [self setObject:title forKey:@"Title"];
    }
    
    if (description) {
        [self setObject:description forKey:@"Description"];
    }
    
    if (webpageUrl) {
        [self setObject:webpageUrl forKey:@"URL"];
    }
    
    if (path) {
        [self setObject:path forKey:@"Path"];
    }
    
    if (thumbImage) {
        [self setObject:thumbImage forKey:@"ThumbImage"];
    }
    
    if (userName) {
        [self setObject:userName forKey:@"UserName"];
    }
    
    if (platformSubType) {
        [self setObject:@(platformSubType) forKey:@"PlatformSubType"];
    }
    
    //小程序
    [self setObject:@(TContentTypeMiniProgram) forKey:@"Type"];
    
}

#pragma mark- 新浪微博
/**
 *  设置新浪微博分享参数
 *
 *  @param text      文本
 *  @param title     标题
 *  @param image     图片对象，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、TImage
 *  @param url       分享链接
 *  @param latitude  纬度
 *  @param longitude 经度
 *  @param objectID  对象ID，标识系统内内容唯一性，应传入系统中分享内容的唯一标识，没有时可以传入nil
 *  @param type      分享类型，仅支持Text、Image、WebPage（客户端分享时）类型
 */
- (void)TSetupSinaWeiboShareParamsByText:(NSString *)text
                                   title:(NSString *)title
                                   image:(id)image
                                     url:(NSURL *)url
                                latitude:(double)latitude
                               longitude:(double)longitude
                                objectID:(NSString *)objectID
                                    type:(TContentType)type {
    
    if (text) {
        [self setObject:text forKey:@"Text"];
    }
    
    if (title) {
        [self setObject:title forKey:@"Title"];
    }
    
    if (image) {
        [self setObject:image forKey:@"Images"];
    }
    
    if (url) {
        [self setObject:url forKey:@"URL"];
    }
    
    if (latitude) {
        [self setObject:@(latitude) forKey:@"Latitude"];
    }
    
    if (longitude) {
        [self setObject:@(longitude) forKey:@"Longitude"];
    }
    
    if (objectID) {
        [self setObject:objectID forKey:@"objectID"];
    }
    
    if (type) {
        [self setObject:@(type) forKey:@"Type"];
    }
    
}

#pragma mark- 通过key获取Value

//分享内容
- (NSString *)text {
    
    if ([self objectForKey:@"Text"]) {
        return [self objectForKey:@"Text"];
    }
    
    return @"";
}

//分享标题
- (NSString *)title {
    
    if ([self objectForKey:@"Title"]) {
        return [self objectForKey:@"Title"];
    }
    
    return @"";
}

//分享链接
- (NSURL *)url {
    
    if ([self objectForKey:@"URL"]) {
        return [self objectForKey:@"URL"];
    }
    
    return nil;
}

- (NSURL *)audioFlashURL {
    
    if ([self objectForKey:@"AudioFlashURL"]) {
        return [self objectForKey:@"AudioFlashURL"];
    }
    
    return nil;
}

- (NSURL *)videoFlashURL {
    
    if ([self objectForKey:@"VideoFlashURL"]) {
        return [self objectForKey:@"VideoFlashURL"];
    }
    
    return nil;
}

- (id)thumbImage {
    
    if ([self objectForKey:@"ThumbImage"]) {
        return [self objectForKey:@"ThumbImage"];
    }
    
    return nil;
}

- (id)images {
    
    if ([self objectForKey:@"Images"]) {
        return [self objectForKey:@"Images"];
    }
    
    return nil;
}

- (NSNumber *)type {
    
    if ([self objectForKey:@"Type"]) {
        return [self objectForKey:@"Type"];
    }
    
    return nil;
}

- (NSNumber *)platformSubType {
    
    if ([self objectForKey:@"PlatformSubType"]) {
        return [self objectForKey:@"PlatformSubType"];
    }
    
    return nil;
}

- (NSString *)extInfo {
    
    if ([self objectForKey:@"ExtInfo"]) {
        return [self objectForKey:@"ExtInfo"];
    }
    return nil;
}

- (id)fileData {
    
    if ([self objectForKey:@"FileData"]) {
        return [self objectForKey:@"FileData"];
    }
    return nil;
}

- (id)emoticonData {
    
    if ([self objectForKey:@"EmoticonData"]) {
        return [self objectForKey:@"EmoticonData"];
    }
    
    return nil;
}

- (NSString *)sourceFileExtension {
    if ([self objectForKey:@"SourceFileExtension"]) {
        return [self objectForKey:@"SourceFileExtension"];
    }
    return nil;
}

- (id)sourceFileData {
    if ([self objectForKey:@"SourceFileData"]) {
        return [self objectForKey:@"SourceFileData"];
    }
    
    return nil;
}

- (NSString *)userName {
    if ([self objectForKey:@"UserName"]) {
        return [self objectForKey:@"UserName"];
    }
    
    return nil;
}

- (NSString *)path {
    if ([self objectForKey:@"Path"]) {
        return [self objectForKey:@"Path"];
    }
    
    return nil;
}

- (NSString *)descriptions {
    if ([self objectForKey:@"Description"]) {
        return [self objectForKey:@"Description"];
    }
    
    return nil;
}

+(NSMutableDictionary *)dictionaryWithUrl:(NSURL*)url {
    
    
    NSString * urlString = [[url query] isEqualToString:@""] ? [url absoluteString] : [url query];
    
    //QQ 网页授权返回url格式有# 所以要处理下
    //auth://www.qq.com?#access_token=68656BB22C0699511CE047EAF2624619&expires_in=7776000&openid=039015BD8F609BD51FFF4B820B50FC50&pay_token=BC389EC1E6B05EFB82A9AA996217826E&state=test&ret=0&pf=openmobile_ios&pfkey=aa3cb964950d309e47ad8c751123f11f&auth_time=1499929922100&page_type=1
    urlString = [urlString stringByReplacingOccurrencesOfString:@"auth://www.qq.com?#" withString:@""];
    
    NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
    
    NSArray *urlComponents = [urlString componentsSeparatedByString:@"&"];
    
    for (NSString *keyValuePair in urlComponents)
    {
        NSRange range=[keyValuePair rangeOfString:@"="];
        [queryStringDictionary setObject:range.length>0?[keyValuePair substringFromIndex:range.location+1]:@"" forKey:(range.length?[keyValuePair substringToIndex:range.location]:keyValuePair)];
    }
    return queryStringDictionary;
}

@end
