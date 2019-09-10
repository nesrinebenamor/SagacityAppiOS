//
//  AppDelegate.h
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 11/28/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong) DBManager* DB;


@end

