#import "ZaloShare.h"
#import <ZaloSDK/ZaloSDK.h>


@implementation ZaloShare

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(shareSingle:(NSDictionary *)config           rejecter:(RCTResponseErrorBlock)reject        resolver:(RCTResponseSenderBlock)resolve                           )
{
    dispatch_async(dispatch_get_main_queue(), ^{
          NSString *urlString = @"zalo://";
          NSURL *url = [NSURL URLWithString:urlString];
          if ([[UIApplication sharedApplication] canOpenURL:url]) {
                  // app da install
                  NSString *message = config[@"message"];
                  NSString *url = config[@"url"];
                  NSString *title = config[@"title"];
                  NSString *linkSource = config[@"linkSource"];
                  NSString *linkThumb = config[@"linkThumb"];
                  NSString *appName = config[@"appName"];
              
                  ZOFeed * feed = [
                                   [ZOFeed alloc]
                                   initWithLink:url
                                   appName: appName
                                   message: message
                                   others: nil
                                   ];
                    feed.message = message;
                  feed.linkTitle = title;
                  feed.linkSource = linkSource;
                  feed.linkThumb = @[linkThumb];
                  feed.link = url;
                  UIViewController *navigationController = [UIViewController self];
              
                  [[ZaloSDK sharedInstance] sendMessage: feed
                   inController:navigationController
                   callback:^(ZOShareResponseObject *response)
                  {
                      NSLog(@"%@", response.message);
                       if (response.isSucess) {
                           resolve(@"success");
                       } else {
                           NSError* error = nil;
                           reject(@"app_not_share", @"app_not_share", error);
                       }
                  }];
              }
              else {
                  NSError* error = nil;
                  reject(@"app_not_install", @"app_not_install", error);
              }
    });
}

RCT_EXPORT_METHOD(shareFeed:(NSDictionary *)config                   resolver:(RCTPromiseResolveBlock)resolve                           rejecter:(RCTPromiseRejectBlock)reject)
{
    dispatch_async(dispatch_get_main_queue(), ^{
          NSString *urlString = @"zalo://";
          NSURL *url = [NSURL URLWithString:urlString];
          if ([[UIApplication sharedApplication] canOpenURL:url]) {
                  // app da install
                  NSString *message = config[@"message"];
                  NSString *url = config[@"url"];
                  NSString *linkTitle = config[@"linkTitle"];
                  NSString *linkSource = config[@"linkSource"];
                  NSString *linkThumb = config[@"linkThumb"];
                  NSString *appName = config[@"appName"];
              
                  ZOFeed * feed = [
                                   [ZOFeed alloc]
                                   initWithLink:url
                                   appName: appName
                                   message: message
                                   others: nil
                                   ];
                  feed.linkTitle = linkTitle;
                  feed.linkSource = linkSource;
                  feed.linkThumb = @[linkThumb];
              
                  UIViewController *navigationController = [UIViewController self];
              
                  [[ZaloSDK sharedInstance] shareFeed: feed
                   inController:navigationController
                   callback:^(ZOShareResponseObject *response)
                  {
                      NSLog(@"%@", response.message);
                       if (response.isSucess) {
                           resolve(@"success");
                       } else {
                           NSError* error = nil;
                           reject(@"app_not_share", @"app_not_share", error);
                       }
                  }];
              }
              else {
                  NSError* error = nil;
                  reject(@"app_not_install", @"app_not_install", error);
              }
    });
}

@end
