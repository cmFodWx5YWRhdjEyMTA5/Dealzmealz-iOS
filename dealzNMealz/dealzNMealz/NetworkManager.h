//
//  NetworkManager.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/9/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <UIKit/UIKit.h>
typedef void(^callbackHandler) (NSError *error, id response, NSHTTPURLResponse *urlResponse);
@interface NetworkManager : NSObject
@property NSURLSession * session;
- (BOOL)isConnectedToNetwork;
+ (instancetype)sharedInstance;
+ (NSArray *)composeBodyData:(NSDictionary *)body;
- (void)postLoginDataToServerURL:(NSString *)url andBody:(NSData *)bodyData withCompletionHandler:(callbackHandler)block;
- (void)postDataToServerURL:(NSString *)url andBody:(NSDictionary *)bodyData withCompletionHandler:(callbackHandler)block;
- (void)postSocailLoginToServerURL:(NSString *)url andBody:(NSDictionary *)bodyData withCompletionHandler:(callbackHandler)block ;
- (void)putDataToServerURL:(NSString *)url andBody:(NSDictionary *)bodyData withCompletionHandler:(callbackHandler)block;
- (void)deleteDataToServerURL:(NSString *)url andBody:(NSDictionary *)bodyData withCompletionHandler:(callbackHandler)block;
- (void)getDataFromServerURL:(NSString *)url withCompletionHandler:(callbackHandler)block;
- (void)postImageToServer:(UIImage *)profileImage userID:(NSString *)userId withUrl:(NSString *)url withCompletionHandler:(callbackHandler)block;
@end
