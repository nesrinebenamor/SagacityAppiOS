//
//  MTReachabilityManager.h
//  loactNotification
//
//  Created by Nessrine Ben Amor on 1/2/16.
//  Copyright © 2016 F&N. All rights reserved.
//
#import <Foundation/Foundation.h>

@class Reachability;

@interface MTReachabilityManager : NSObject

@property (strong, nonatomic) Reachability *reachability;

#pragma mark -
#pragma mark Shared Manager
+ (MTReachabilityManager *)sharedManager;

#pragma mark -
#pragma mark Class Methods
+ (BOOL)isReachable;
+ (BOOL)isUnreachable;
+ (BOOL)isReachableViaWWAN;
+ (BOOL)isReachableViaWiFi;

@end
