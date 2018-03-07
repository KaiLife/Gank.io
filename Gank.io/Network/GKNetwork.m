//
//  GKNetwork.m
//  Gank.io
//
//  Created by 王权伟 on 2018/2/9.
//  Copyright © 2018年 王权伟. All rights reserved.
//

#import "GKNetwork.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface GKNetwork ()

@property(strong, nonatomic)AFURLSessionManager *manager;

@end

@implementation GKNetwork

+ (void)postWithUrl:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://gank.io/%@",url]]];

    NSData * postBody = [NSData data];
    
    if ([NSJSONSerialization isValidJSONObject:parameter]) {
        
        postBody = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
    }

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postBody];
    
    [GKNetwork handleRequest:request success:success failure:failure];
}

+ (void)getGithubWithUrl:(NSString *)url success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSURLSessionDataTask *dataTask = [getSessionManager() dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error == nil) {
            
            if (success) {
                success(responseObject);
            }
            
            [self dissmissTips];
        }
        else {
            
            if (failure) {
                failure(error);
            }
            
            if([error.userInfo valueForKey:@"NSLocalizedDescription"] != nil){
                [self showMessageTip:[error.userInfo valueForKey:@"NSLocalizedDescription"] detail:nil timeOut:1.5f];
            }
            else{
                [self showMessageTip:@"服务器开小差了" detail:@"请稍后再试" timeOut:1.5f];
            }
            
        }
        
    }];
    
    [dataTask resume];
}

+ (void)getWithUrl:(NSString *)url success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"http://gank.io/%@",url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    [GKNetwork handleRequest:request success:success failure:failure];
}

+ (void)handleRequest:(NSURLRequest *)request success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure {
    
    NSURLSessionDataTask *dataTask = [getSessionManager() dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error == nil) {
            
            if (success) {
                NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                success(jsonDict);
                [self dissmissTips];
            }
            
        }
        else {
            
            if (failure) {
                failure(error);
            }
            
            if([error.userInfo valueForKey:@"NSLocalizedDescription"] != nil){
                [self showMessageTip:[error.userInfo valueForKey:@"NSLocalizedDescription"] detail:nil timeOut:1.5f];
            }
            else{
                [self showMessageTip:@"服务器开小差了" detail:@"请稍后再试" timeOut:1.5f];
            }
            
        }
        
    }];
    
    [dataTask resume];
    
}

static AFURLSessionManager *sessionManager = nil;
AFURLSessionManager* getSessionManager() {
    
    if (sessionManager == nil) { //AFURLSessionManager 不是单例  避免重复创建
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 20.f; //超时时间设为20s
        sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //证书配置 https 会使用
        //        manager.securityPolicy = customSecurityPolicy();
    }
    
    return sessionManager;
}

@end
