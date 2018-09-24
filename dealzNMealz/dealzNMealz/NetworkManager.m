//
//  NetworkManager.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/9/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "NetworkManager.h"
#import "GlobalWidgets.h"
#import "AppDelegate.h"
@implementation NetworkManager
+ (instancetype)sharedInstance {
    static NetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkManager alloc] init];
    });
    return sharedInstance;
}


- (void)postDataToServerURL:(NSString *)url andBody:(NSDictionary *)bodyData withCompletionHandler:(callbackHandler)block {
    if ([self isConnectedToNetwork]) {
         [AppDelegate startAnimating];
         if (bodyData != nil) {
            NSLog(@"url: %@ <==> POST <==> BODY : %@",url, bodyData);
        }
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyData options:0 error:nil];
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        
        dispatch_async(concurrentQueue, ^{
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[[NSURL alloc]initWithString:url]];
            
                [request addValue:@"application/json;" forHTTPHeaderField:@"Content-Type"];
                
               // [request addValue:Token forHTTPHeaderField:@"Authorization"];
                
                [request setHTTPBody:jsonData];
       
            
            //  [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            
            
            [request setHTTPMethod:@"POST"];
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
            self.session = [NSURLSession sessionWithConfiguration:configuration];
            
            NSURLSessionTask * task = [self.session uploadTaskWithRequest:request fromData:jsonData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                // NSLog(@"response %@",response);
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                if (error) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //   block(error , response);
                        block(error,response,httpResponse);
                        [AppDelegate stopAnimating];
                    });
                    
                    return;
                    
                } else {
                    NSError *error = nil;
                    @try {
                        id responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                        
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            block(error , responseData,httpResponse);
                            [AppDelegate stopAnimating];
                        });
                    } @catch (NSException *exception) {
                        
                        
                        [AppDelegate stopAnimating];
                    }
                    
                    
                }
                
                
                
            }];
            /*
             */
            [task resume];
            
            
        });
    }
    else {
        [self addAlertToView];
        
    }
    
    
    
}





- (void)getDataFromServerURL:(NSString *)url withCompletionHandler:(callbackHandler)block {
    
    if ([self isConnectedToNetwork]) {
        
        [AppDelegate startAnimating];
        
        NSData *data = [[[[self class] composeBodyData:nil] componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        
        dispatch_async(concurrentQueue, ^{
            NSLog(@"GET url: %@",url);
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[[NSURL alloc]initWithString:url]];
            
           
                [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            
           
            
            [request setHTTPMethod:@"GET"];
            
            
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
            self.session = [NSURLSession sessionWithConfiguration:configuration];
            
            NSURLSessionTask * task = [self.session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                
                if (error) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        block(error,response,httpResponse);
                        [AppDelegate stopAnimating];
                    });
                    
                    return;
                    
                } else {
                    NSError *error = nil;
                    @try {
                        id responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            block(error , responseData,httpResponse);
                            [AppDelegate stopAnimating];
                        });
                    } @catch (NSException *exception) {
                        
                        [AppDelegate stopAnimating];
                    }
                    
                    
                }
                
                
            }];
            [task resume];
            
            
        });
    }
    else {
        
        [self addAlertToView];
    }
}

- (void)postImageToServer:(UIImage *)profileImage userID:(NSString *)userId withUrl:(NSString *)url withCompletionHandler:(callbackHandler)block {
    
    if ([self isConnectedToNetwork]) {
        [AppDelegate startAnimating];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        //Set Params
        [request setHTTPShouldHandleCookies:NO];
        [request setTimeoutInterval:60];
        [request setHTTPMethod:@"POST"];
        NSData *imageData = UIImageJPEGRepresentation(profileImage, 1);
        
        
        float maxFileSize = 1 * 1024;
        
        if ([imageData length] > maxFileSize) {
            imageData = UIImageJPEGRepresentation(profileImage, maxFileSize/[imageData length]);
            profileImage = [UIImage imageWithData:imageData];
        }
        
        
        NSString *boundary = @"------VohpleBoundary4QuqLuM1cE5lMwCy";
        
        // set Content-Type in HTTP header
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
      //  NSString *Token = [[WAYTokenManagementService tokenSharedInstance]getToken];
        
      //  [request addValue:Token forHTTPHeaderField:@"Authorization"];
        
        // post body
        NSMutableData *body = [NSMutableData data];
        
        //Populate a dictionary with all the regular values you would like to send.
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        
        [parameters setValue:userId forKey:@"userId"];
        
        [parameters setValue:profileImage forKey:@"file"];
        
        // add params (all params are strings)
        for (NSString *param in parameters) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        NSString *FileParamConstant = @"file";
        
        
        //Assuming data is not nil we add this to the multipart form
        if (imageData)
        {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n",FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type:image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:imageData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        //Close off the request with the boundary
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // setting the body of the post to the request
        [request setHTTPBody:body];
        
        // set URL
        [request setURL:[NSURL URLWithString:url]];
        
        self.session = [NSURLSession sharedSession];
        
        NSURLSessionTask * task = [self.session dataTaskWithRequest:request
                                                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                      
                                                      if (error) {
                                                          
                                                          
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              
                                                              block(error,response,httpResponse);
                                                              [AppDelegate stopAnimating];
                                                          });
                                                          
                                                          return;
                                                          
                                                      } else {
                                                          NSError *error = nil;
                                                          @try {
                                                              id responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                                              
                                                              
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  
                                                                  block(error , responseData,httpResponse);
                                                                  [AppDelegate stopAnimating];
                                                              });
                                                          } @catch (NSException *exception) {
                                                              
                                                              [AppDelegate stopAnimating];
                                                          }
                                                          
                                                          
                                                      }
                                                  }];
        [task resume];
        
    } else {
        
       [self addAlertToView];
    }
    
    
}




- (void)addAlertToView {
    
    UIAlertController *alert = [GlobalWidgets showAlertWithTitle:@"Network Error" yesButtonTitle:@"Ok" noButtonTitle:nil];
    
    id rootView = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootView isKindOfClass:[UINavigationController class]])
    {
        rootView = ((UINavigationController *)rootView).viewControllers.firstObject;
    }
    if ([rootView isKindOfClass:[UITabBarController class]])
    {
        rootView = ((UITabBarController *)rootView).selectedViewController;
    }
    [rootView presentViewController:alert animated:YES completion:nil];
    
    
    
}


+ (NSArray *)composeBodyData:(NSDictionary *)body
{
    NSMutableArray *dataParameter = [[NSMutableArray alloc]init];
    
    NSArray *keyAry = [body allKeys];
    for (NSString *key in keyAry) {
        [dataParameter addObject:[NSString stringWithFormat:@"%@=%@",key,body[key]]];
    }
    
    return dataParameter;
}


- (BOOL)isConnectedToNetwork {
    
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    if (reachability == NULL)
        return false;
    
    if (!(SCNetworkReachabilityGetFlags(reachability, &flags)))
        return false;
    
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
        // if target host is not reachable
        return false;
    
    
    BOOL isReachable = false;
    
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0) {
        // if target host is reachable and no connection is required
        //  then we'll assume (for now) that your on Wi-Fi
        isReachable = true;
    }
    
    
    if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
         (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)) {
        // ... and the connection is on-demand (or on-traffic) if the
        //     calling application is using the CFSocketStream or higher APIs
        
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            // ... and no [user] intervention is needed
            isReachable = true;
        }
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
        // ... but WWAN connections are OK if the calling application
        //     is using the CFNetwork (CFSocketStream?) APIs.
        isReachable = true;
    }
    
    
    return isReachable;
    
    
}

@end
//
//  ApiServiceCall.m
//  way
//
//  Created by Vivek Jain on 27/01/17.
//  Copyright © 2017 sasken. All rights reserved.
//


